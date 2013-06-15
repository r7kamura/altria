require "magi/command"
require "magi/configuration"
require "magi/plugin_manager"
require "magi/version"
require "magi/workspace"

module Magi
  class << self
    def configuration
      @configuration ||= Magi::Configuration.new
    end

    def plugin_manager
      @plugin_manager ||= Magi::PluginManager.new
    end
  end
end
