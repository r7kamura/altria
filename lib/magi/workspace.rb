module Magi
  class Workspace
    attr_reader :path

    def initialize(path)
      @path = Pathname.new(path)
    end

    def chdir
      Dir.chdir(path) { yield }
    end
  end
end
