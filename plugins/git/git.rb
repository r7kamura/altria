require "open3"

module Magi
  class Repository
    delegate :exist?, to: :directory

    attr_reader :job

    def initialize(job)
      @job = job
    end

    def directory
      @directory ||= Pathname.new("jobs/#{job.id}")
    end

    def clone
      validate_existence_of_git_url
      command("git clone #{job.git_url} #{directory}")
    end

    def update
      clone unless exist?
      command("cd #{directory} && git pull")
    end

    def revision
      command("cd #{directory} && git rev-parse HEAD").rstrip
    end

    def updated?
      revision != job.last_finished_build.try(:revision)
    end

    private

    def command(script)
      Open3.capture3(script)[0]
    end

    def mkdir
      directory.parent.mkpath
    end

    def validate_existence_of_git_url
      raise GitUrlNotFound unless job.git_url
    end

    class GitUrlNotFound < StandardError
      def message
        "You must set `git_url`"
      end
    end
  end
end

Job.class_eval do
  property(:git_url)

  before_hook do
    if git_url.present?
      repository.update
      repository.updated?
    end
  end

  after_hook do
    if git_url.present?
      current_build.update_revision
    end
  end

  def repository
    @repository ||= Magi::Repository.new(self)
  end
end

Build.class_eval do
  property(:revision)

  def update_revision
    update_properties(revision: job.repository.revision)
  end
end
