require "yaml"

class PositiveRecord
  extend ActiveModel::Naming
  include ActiveModel::Validations

  class FileNotFound < StandardError; end

  class << self
    attr_writer :directory

    def find(filename)
      if (pathname = pathize(filename)).exist?
        new(yamlize(pathname))
      else
        raise FileNotFound, "#{pathname} is not found"
      end
    end

    def all
      Pathname.glob("#{directory}/*/#{filename}").map do |pathname|
        Job.new(yamlize(pathname))
      end
    end

    def create(attributes = {})
      new(attributes).tap(&:save)
    end

    def directory
      @directory or raise "You must set #{self}.directory"
    end

    def exists?(id)
      pathize(id).exist?
    end

    def yamlize(pathname)
      YAML.load_file(pathname)
    end

    def pathize(id)
      directory + "#{id}/#{filename}"
    end

    private

    def filename
      "attributes.yml"
    end
  end

  attr_reader :attributes

  delegate :[], to: :attributes

  delegate :to_hash, to: :attributes

  delegate :to_yaml, to: :to_hash

  validates :id, presence: true

  def initialize(attributes = {})
    @attributes = attributes.with_indifferent_access
  end

  def id
    self[:id]
  end

  def pathname
    self.class.pathize(id)
  end

  def ==(job)
    pathname == job.pathname
  end

  def update_attributes(args)
    attributes.merge!(args).tap { save }
  end

  def save
    if valid?
      write
      true
    else
      false
    end
  end

  def destroy
    pathname.delete
    self
  end

  def reload
    @attributes = self.class.yamlize(pathname).with_indifferent_access
    self
  end

  private

  def write
    pathname.dirname.mkdir rescue nil
    pathname.open("w") {|file| file.puts(to_yaml) }
  end
end
