module Magi
  class Command
    def self.call(*args)
      new(*args).call
    end

    def initialize(argv)
      @argv = argv
    end

    def call
      puts name # for debug
    end

    private

    def name
      @argv[0]
    end
  end
end
