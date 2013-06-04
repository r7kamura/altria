require "tempfile"

module Magi
  class Executer
    def self.execute(*args)
      new(*args).execute
    end

    def initialize(script)
      @script = script
    end

    def execute
      { status: status, output: output }
    end

    private

    def tempfile
      @tempfile ||= Tempfile.new("")
    end

    def status
      system(@script, out: tempfile, err: tempfile)
    end

    def output
      tempfile.tap(&:close).open.read
    end
  end
end
