module Altria
  class Workspace
    attr_reader :path

    def initialize(path)
      @path = Pathname.new(path)
    end

    def chdir
      mkpath_unless_exist
      Dir.chdir(path) { yield }
    end

    def mkpath_unless_exist
       mkpath unless exist?
    end

    def mkpath
      path.mkpath
    end

    def exist?
      path.exist?
    end
  end
end
