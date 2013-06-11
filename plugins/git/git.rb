require "open3"
require "pathname"

class Repository
  delegate :exist?, to: :directory

  attr_reader :job

  def initialize(job)
    @job = job
  end

  def directory
    @directory ||= Pathname.new("jobs/#{job.name}/repository")
  end

  def clone
    directory.parent.mkpath
    system("git clone #{job.repository_url} #{directory}")
  end

  def update
    system("cd #{directory} && git pull")
  end

  def revision
    Open3.capture3("cat #{directory}/.git/refs/heads/git")[0].strip
  end

  def updated?
    revision != job.last_finished_build.revision
  end

  def system(command)
    super(command, out: IO::NULL, err: IO::NULL)
  end
end

Job.class_eval do
  def repository
    @repository ||= Repository.new(self)
  end
end

Build.class_eval do
  property(:revision)
end
