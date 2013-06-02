module PositiveRecord
  class Relation
    include Enumerable

    attr_reader :klass, :options

    def initialize(klass, options = {})
      @klass = klass
      @options = options
    end

    def each
      Pathname.glob("#{directory}/*/attributes.yml").each do |pathname|
        yield klass.new_with_yaml(pathname)
      end
    end

    def directory
      if parent
        parent.pathname.dirname + klass.name.underscore.pluralize
      else
        klass.directory
      end
    end

    def create(attributes = {})
      if parent
        klass.create(attributes.merge(:"#{parent_name}_id" => parent.id))
      else
        klass.create(attributes)
      end
    end

    def parent
      options[:parent]
    end

    def parent_name
      parent.class.name.underscore
    end
  end
end
