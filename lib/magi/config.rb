module Magi
  module Config
    class << self
      attr_accessor :jobs_directory, :root_directory

      def reset
        self.root_directory = Pathname.pwd
        self.jobs_directory = root_directory + "jobs"
      end
    end

    reset
  end
end
