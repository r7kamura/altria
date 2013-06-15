require "magi/command"
require "magi/plugin_manager"
require "magi/version"
require "magi/workspace"

module Magi
  class << self
    def workspace
      @workspace ||= Magi::Workspace.new(workspace_path)
    end

    def plugin_manager
      @plugin_manager ||= Magi::PluginManager.new
    end

    private

    def workspace_path
      ENV["WORKSPACE_PATH"] || "."
    end
  end
end
