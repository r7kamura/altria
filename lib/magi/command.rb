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
        setup
      when "start"
        start
      else
        puts "Usage: magi {setup|start}"
      end
    end

    private

    def name
      @argv[0]
    end

    def setup
      system("cd #{root_path} && bundle exec rake db:create db:migrate")
    end

    def start
      system("cd #{root_path} && foreman start")
    end

    def root_path
      File.expand_path("../../..", __FILE__)
    end
  end
end
