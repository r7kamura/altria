require "fileutils"
require "yaml"

module PositiveRecord
  class Base
    extend ActiveModel::Naming
    include ActiveModel::Validations

    class << self
      attr_writer :directory

      def new_with_yaml(pathname)
        attributes = YAML.load_file(pathname)
        new(attributes)
      end

      def find(filename)
        if (pathname = pathize(filename)).exist?
          new_with_yaml(pathname)
        else
          raise PositiveRecord::RecordNotFound, "#{pathname} is not found"
        end
      end

      def scoped(options = {})
        PositiveRecord::Relation.new(self, options)
      end

      def all
        Pathname.glob("#{directory}/*/attributes.yml").map do |pathname|
          new_with_yaml(pathname)
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

      def pathize(id)
        directory + "#{id}/attributes.yml"
      end

      def property(name)
        properties << name
      end

      def properties
        @properties ||= []
      end

      def belongs_to(name)
        define_method(name) do
          name.to_s.camelize.constantize.find(send("#{name}_id"))
        end
      end

      def has_many(name)
        define_method(name) do
          name.to_s.singularize.camelize.constantize.scoped(parent: self)
        end
      end
    end

    attr_reader :attributes

    delegate :[], to: :attributes

    delegate :to_hash, to: :attributes

    delegate :to_yaml, to: :to_hash

    def initialize(attributes = {})
      @attributes = attributes.with_indifferent_access
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
      @attributes = YAML.load_file(pathname).with_indifferent_access
      self
    end

    def persisted?
      pathname.exist?
    end

    private

    def write
      mkdir_p
      pathname.open("w") {|file| file.puts(to_yaml) }
    end

    def mkdir_p
      FileUtils.mkdir_p(pathname.dirname)
    rescue Errno::ENOENT
    end

    def method_missing(method_name, *args, &block)
      if self.class.properties.include?(method_name)
        self[method_name]
      else
        super
      end
    end
  end
end
