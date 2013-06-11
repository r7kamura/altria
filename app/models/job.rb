class Job < ActiveRecord::Base
  extend Magi::Proprietary

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

    def enqueue_with_before_hooks
      select(&:scheduled?).each(&:enqueue_with_before_hooks)
    end

    def before_hook(&block)
      before_hooks << block
    end

    def before_hooks
      @before_hooks ||= []
    end

    def after_hook(&block)
      after_hooks << block
    end

    def after_hooks
      @after_hooks ||= []
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

  def enqueue_with_before_hooks
    enqueue if execute_before_hooks
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
    params.slice(:name, *self.class.properties).each do |key, value|
      send("#{key}=", value)
    end
    tap(&:save)
  end

  private

  def execute
    Magi::Executer.execute(script)
  end

  def execute_with_after_hooks
    execute_without_after_hooks.tap { execute_after_hooks }
  end
  alias_method_chain :execute, :after_hooks

  def execute_before_hooks
    self.class.before_hooks.all? {|hook| instance_exec(&hook) != false }
  end

  def execute_after_hooks
    self.class.after_hooks.all? {|hook| instance_exec(&hook) != false }
  end

  def raise_script_not_found
    raise ScriptNotFound, 'You must set properties["script"]'
  end

  class ScriptNotFound < StandardError; end
end
