module Magi
  module Proprietary
    extend ActiveSupport::Concern

    def update_properties(properties)
      properties.each do |key, value|
        send("#{key}=", value)
      end
      save
    end

    module ClassMethods
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
  end
end
