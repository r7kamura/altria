class Job < ActiveRecord::Base
  attr_accessible :name, :config

  serialize :config, Hash

  validates :name, presence: true

  has_many :builds

  scope :recent, -> { order("updated_at DESC") }

  delegate :status_name, :status_icon_css_class, to: :last_finished_build

  class << self
    def queue
      select(&:scheduled?).each(&:queue)
    end

    def property(name)
      define_method(name) do
        config[name.to_s]
      end
    end
  end

  property(:description)

  property(:schedule)

  property(:script)

  def start
    script ? execute : raise_script_not_found
  end

  def scheduler
    Magi::Scheduler.new(schedule)
  end

  def scheduled?
    schedule && scheduler.scheduled?
  end

  def queue
    builds.create.tap(&:queue)
  end

  def status
    last_finished_build.try(:status)
  end

  def last_finished_build
    builds.finished.order(:finished_at).last
  end

  private

  def execute
    Magi::Executer.execute(script)
  end

  def raise_script_not_found
    raise ScriptNotFound, 'You must set script["config"]'
  end

  class ScriptNotFound < StandardError; end
end
