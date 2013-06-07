require "open3"

module Magi
  class Executer
    def self.execute(*args)
      new(*args).execute
    end

    attr_reader :script

    def initialize(script)
      @script = script
    end

    def execute
      output, status = Open3.capture2e(script)
      { output: output, status: status.success? }
    end
  end
end
