class Job < ActiveRecord::Base
  include Altria::Proprietary

  serialize :properties, Hash

  validates :name, presence: true

  has_many :builds

  scope :recent, -> { order("updated_at DESC") }

  delegate :status, :status_name, :status_icon_css_class, to: :last_finished_build, allow_nil: true

  delegate :scheduled?, to: :scheduler, allow_nil: true

  property(:description, type: :text)

  property(:script, type: :text)

  property(:schedule, placeholder: "* * * * *")

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

  def run
    script ? execute : raise_script_not_found
  end

  def scheduler
    Altria::Scheduler.new(schedule) if schedule.present?
  end

  def enqueue
    builds.create.tap(&:enqueue).tap { execute_after_enqueues }
  end

  def enqueue_with_before_enqueues
    enqueue if execute_before_enqueues
  end

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
    params.slice(:name, *self.class.property_names).each {|key, value| send("#{key}=", value) }
    tap(&:save)
  end

  def workspace
    @workspace ||= Altria::Workspace.new(workspace_path)
  end

  def workspace_path
    Altria.configuration.workspace_path + "jobs/#{id}"
  end

  def execute
    execute_before_executes
    execute_without_before_executes.tap { execute_after_executes }
  end

  private

  def execute_without_before_executes
    workspace.chdir { execute_script }
  end

  def execute_script
    Altria::Executer.execute(script)
  end

  def execute_before_enqueues
    self.class.before_enqueues.all? {|hook| instance_exec(&hook) != false }
  end

  def execute_after_enqueues
    self.class.after_enqueues.all? {|hook| instance_exec(&hook) != false }
  end

  def execute_before_executes
    self.class.before_executes.all? {|hook| instance_exec(&hook) != false }
  end

  def execute_after_executes
    self.class.after_executes.all? {|hook| instance_exec(&hook) != false }
  end

  def raise_script_not_found
    raise ScriptNotFound, 'You must set properties["script"]'
  end

  class ScriptNotFound < StandardError; end
end
