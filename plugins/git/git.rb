require "open3"

module Magi
  class Repository
    attr_reader :job

    def initialize(job)
      @job = job
    end

    def before_enqueue
      if has_repository_url?
        clone unless cloned?
        update
        updated_since_last_finished_build?
      end
    end

    def before_execute
      if has_repository_url?
        clone
      end
    end

    def after_execute
      if has_repository_url?
        job.current_build.update_properties(revision: revision)
      end
    end

    def clone
      validate_existence_of_repository_url
      command("git clone #{job.repository_url} #{path}")
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

    def command(script)
      Open3.capture3(script)[0]
    end

    def path
      job.workspace.path + "repository"
    end

    def has_repository_url?
      job.repository_url.present?
    end

    private

    def validate_existence_of_repository_url
      raise RepositoryUrlNotFound unless has_repository_url?
    end

    class RepositoryUrlNotFound < StandardError
      def message
        "You must set `repository_url`"
      end
    end
  end
end

Job.class_eval do
  property(:repository_url)

  before_enqueue { repository.before_enqueue }

  before_execute { repository.before_execute }

  after_execute { repository.after_execute }

  def repository
    @repository ||= Magi::Repository.new(self)
  end
end

Build.property(:revision)
