class BuildWorker
  include Sidekiq::Worker

  # Takes a build id and invokes it.
  def perform(id)
    Build.find(id).run
  end
end
