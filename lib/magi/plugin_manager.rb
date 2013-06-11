module Magi
  class PluginManager
    def plugins_directory
      @plugins_directory ||= Pathname.new("plugins")
    end

    def load_plugins
      Dir.glob("#{Dir.pwd}/#{plugins_directory}/*/*.rb").sort.each do |path|
        require path
      end
    end
  end
end
