class Job < ActiveRecord::Base
  attr_accessible :name, :properties

  serialize :properties, Hash

  validates :name, presence: true

  has_many :builds

  scope :recent, -> { order("updated_at DESC") }

  delegate :status, :status_name, :status_icon_css_class, to: :last_finished_build, allow_nil: true

  class << self
    def create_with_properties(properties)
      job = new
      properties.each {|key, value| job.send("#{key}=", value) }
      job.tap(&:save)
    end

    def queue
      select(&:scheduled?).each(&:queue)
    end

    def property(name)
      properties << name

      define_method(name) do
        properties[name.to_s]
      end

      define_method("#{name}=") do |value|
        properties[name.to_s] = value
      end
    end

    def properties
      @properties ||= []
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

  def status_name
    last_finished_build.try(:status_name) || "unfinished"
  end

  def last_finished_build
    builds.finished.order(:finished_at).last
  end

  def update_attributes_with_properties(properties)
    properties.each {|key, value| send("#{key}=", value) }
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
