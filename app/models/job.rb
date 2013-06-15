class Job < ActiveRecord::Base
  include Magi::Proprietary

  attr_accessible :name, :properties

  serialize :properties, Hash

  validates :name, presence: true

  has_many :builds

  scope :recent, -> { order("updated_at DESC") }

  delegate :status, :status_name, :status_icon_css_class, to: :last_finished_build, allow_nil: true

  delegate :scheduled?, to: :scheduler, allow_nil: true

  class << self
    def create_with_properties(params)
      new.update_attributes_with_properties(params)
    end

    def scheduled
      select(&:scheduled?)
    end

    def before_enqueue(&block)
      before_enqueues << block
    end

    def before_enqueues
      @before_enqueues ||= []
    end

    def after_enqueue(&block)
      after_enqueues << block
    end

    def after_enqueues
      @after_enqueues ||= []
    end

    def before_execute(&block)
      before_executes << block
    end

    def before_executes
      @before_executes ||= []
    end

    def after_execute(&block)
      after_executes << block
    end

    def after_executes
      @after_executes ||= []
    end
  end

  property(:description)

  property(:schedule)

  property(:script)

  def start
    script ? execute : raise_script_not_found
  end

  def scheduler
    Magi::Scheduler.new(schedule) if schedule
  end

  def enqueue
    builds.create.tap(&:enqueue)
  end

  def enqueue_with_before_enqueues
    if self.class.before_enqueues.all? {|hook| instance_exec(&hook) != false }
      enqueue_without_before_enqueues
    end
  end
  alias_method_chain :enqueue, :before_enqueues

  def enqueue_with_after_enqueues
    enqueue_without_after_enqueues.tap do
      self.class.after_enqueues.all? {|hook| instance_exec(&hook) != false }
    end
  end
  alias_method_chain :enqueue, :after_enqueues

  def status_name
    last_finished_build.try(:status_name) || "unfinished"
  end

  def current_build
    builds.running.latest
  end

  def last_finished_build
    builds.finished.order(:finished_at).last
  end

  def update_attributes_with_properties(params)
    params.slice(:name, *self.class.properties).each do |key, value|
      send("#{key}=", value)
    end
    tap(&:save)
  end

  def workspace
    @workspace ||= Magi::Workspace.new(workspace_path)
  end

  private

  def workspace_path
    Magi.workspace.path + "jobs/#{id}"
  end

  def execute
    workspace.chdir { Magi::Executer.execute(script) }
  end

  def execute_with_before_executes
    self.class.before_executes.all? {|hook| instance_exec(&hook) != false }
    execute_without_before_executes
  end
  alias_method_chain :execute, :before_executes

  def execute_with_after_executes
    execute_without_after_executes.tap do
      self.class.after_executes.all? {|hook| instance_exec(&hook) != false }
    end
  end
  alias_method_chain :execute, :after_executes

  def raise_script_not_found
    raise ScriptNotFound, 'You must set properties["script"]'
  end

  class ScriptNotFound < StandardError; end
end
