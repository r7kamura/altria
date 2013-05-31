# Provides command line interface for Magi.
#
# Examples
#
#   # Takes ARGV and invokes a job.
#   Magi::Command.call(ARGV)
#
#   # Invokes "setup" command to set up your database.
#   Magi::Command.call(["setup"])
#
#   # Invokes "web" command to start a HTTP server.
#   Magi::Command.call(["web"])
#
#   # Invokes "worker" command to start a worker for your jobs.
#   Magi::Command.call(["worker"])
#
module Magi
  class Command
    def self.call(*args)
      new(*args).call
    end

    def initialize(argv)
      @argv = argv
    end

    def call
      case name
      when "setup"
      when "start"
      when "worker"
      else
      end
    end

    private

    def name
      @argv[0]
    end
  end
end
