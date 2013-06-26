# Provides command line interface for Altria.
#
# Examples
#
#   # Takes ARGV and invokes a job.
#   Altria::Command.call(ARGV)
#
#   # Invokes "setup" command to set up your database.
#   Altria::Command.call(["setup"])
#
#   # Invokes "start" command to start the processes.
#   Altria::Command.call(["start"])
#
module Altria
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
        puts "Usage: altria {setup|start}"
      end
    end

    private

    def name
      @argv[0]
    end

    def setup
      system(env, "cd #{root_path} && bundle install && bundle exec rake db:create db:migrate")
    end

    def start
      system(env, "cd #{root_path} && bundle exec foreman start")
    end

    def root_path
      File.expand_path("../../..", __FILE__)
    end

    def workspace_path
      Dir.pwd
    end

    def env
      { "WORKSPACE_PATH" => workspace_path }
    end
  end
end
