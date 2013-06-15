module Magi
  class PluginManager
    def plugins_directories
      [Rails.root + "plugins", Pathname.pwd + "plugins"].uniq
    end

    def load_plugins
      plugin_filepaths.each {|path| require path }
    end

    private

    def plugin_filepaths
      Dir.glob("#{plugins_directories_pattern}/*/*.rb").sort
    end

    def plugins_directories_pattern
      plugins_directories.join(",")
    end
  end
end
