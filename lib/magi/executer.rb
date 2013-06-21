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
      { output: output, status: status.success? }
    end

    private

    def output
      result[0]
    end

    def status
      result[1]
    end

    def result
      @result ||= Open3.capture2e(lines)
    end

    def lines
      script.gsub("\n", ";")
    end
  end
end
