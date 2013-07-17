module Altria
  class Configuration
    attr_accessor :workspace_path

    def initialize
      @workspace_path = Pathname.new(".")
    end
  end
end
