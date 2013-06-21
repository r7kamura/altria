require "open3"

module Magi
  class Repository
    attr_reader :job

    def initialize(job)
      @job = job
    end

    def clone
      validate_existence_of_git_url
      command("git clone #{job.git_url} #{path}")
    end

    def update
      command("cd #{path} && git pull")
    end

    def revision
      command("cd #{path} && git rev-parse HEAD").rstrip
    end

    def updated_since_last_finished_build?
      revision != job.last_finished_build.try(:revision)
    end

    def cloned?
      path.join(".git").exist?
    end

    private

    def command(script)
      Open3.capture3(script)[0]
    end

    def validate_existence_of_git_url
      raise GitUrlNotFound unless job.git_url
    end

    def path
      job.workspace.path + "repository"
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

  before_enqueue do
    if git_url.present?
      repository.clone unless repository.cloned?
      repository.update
      repository.updated_since_last_finished_build?
    end
  end

  before_execute do
    if git_url.present?
      repository.clone unless repository.cloned?
    end
  end

  after_execute do
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
