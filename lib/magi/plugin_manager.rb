module Magi
  class PluginManager
    def plugins_directory
      @plugins_directory ||= Rails.root + "plugins"
    end

    def load_plugins
      Dir.glob("#{plugins_directory}/*/*.rb").sort.each do |path|
        require path
      end
    end
  end
end
