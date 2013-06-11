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

    def enqueue
      select(&:scheduled?).each(&:enqueue)
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

  def status_name
    last_finished_build.try(:status_name) || "unfinished"
  end

  def last_finished_build
    builds.finished.order(:finished_at).last
  end

  def update_attributes_with_properties(params)
    (self.class.properties + [:name]).each {|key| send("#{key}=", params[key]) }
    tap(&:save)
  end

  private

  def execute
    Magi::Executer.execute(script)
  end

  def raise_script_not_found
    raise ScriptNotFound, 'You must set properties["script"]'
  end

  class ScriptNotFound < StandardError; end
end
