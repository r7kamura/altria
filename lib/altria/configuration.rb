module Altria
  class Configuration
    attr_accessor :workspace_path

    def initialize
      @workspace_path = Pathname.new(ENV["WORKSPACE_PATH"] || ".")
    end
  end
end
