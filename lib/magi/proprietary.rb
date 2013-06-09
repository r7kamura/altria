module Magi
  module Proprietary
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
