class Build < ActiveRecord::Base
  attr_accessible :finished_at, :started_at, :status

  belongs_to :job, touch: true

  # Creates, queues, and returns itself.
  def self.create_with_queue(*args)
    create(*args).tap(&:queue)
  end

  # Pushes this build to worker's queue.
  def queue
    BuildWorker.perform_async(id)
  end

  # Runs this build, usually called from BuildWorker#perform.
  def run
    start
    status = job.run
    finish(status)
  end

  private

  # Marks started_at.
  def start
    update_attributes!(started_at: Time.now)
  end

  # Marks finished_at and status. The status is usually a ret-val of Job#run.
  def finish(status)
    update_attributes!(finished_at: Time.now, status: status)
  end
end
