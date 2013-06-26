module Altria
  module Proprietary
    extend ActiveSupport::Concern

    def update_properties(properties)
      properties.each do |key, value|
        send("#{key}=", value)
      end
      save
    end

    module ClassMethods
      def property(name, options = {})
        property = Property.new(name, options)
        properties << property

        define_method(name) do
          properties[name.to_s]
        end

        define_method("#{name}=") do |value|
          properties[name.to_s] = begin
            case
            when property.type != :boolean
              value
            when value.to_s == "false"
              false
            else
              true
            end
          end
        end
      end

      def properties
        @properties ||= []
      end

      def property_names
        properties.map(&:name)
      end
    end

    class Property
      attr_reader :name, :options

      def initialize(name, options = {})
        @name, @options = name, options
      end

      def type
        options[:type] || :string
      end
    end
  end
end
