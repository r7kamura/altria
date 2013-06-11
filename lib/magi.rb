require "magi/command"
require "magi/plugin_manager"
require "magi/version"

module Magi
  def self.plugin_manager
    @plugin_manager ||= Magi::PluginManager.new
  end
end
