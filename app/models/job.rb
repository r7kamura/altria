class Job < ActiveRecord::Base
  attr_accessible :name, :config

  serialize :config, Hash

  validates :name, presence: true

  has_many :builds

  scope :alphabetical, -> { order("name") }

  def self.queue
    select(&:scheduled?).each(&:queue)
  end

  def start
    has_script? ? execute : raise_script_not_found
  end

  def script
    config["script"]
  end

  def schedule
    config["schedule"]
  end

  def scheduler
    Magi::Scheduler.new(schedule)
  end

  def scheduled?
    has_schedule? && scheduler.scheduled?
  end

  def queue
    builds.create.tap(&:queue)
  end

  private

  def has_script?
    !!script
  end

  def has_schedule?
    !!schedule
  end

  def execute
    Magi::Executer.execute(script)
  end

  def raise_script_not_found
    raise ScriptNotFound, 'You must set script["config"]'
  end

  class ScriptNotFound < StandardError; end
end
