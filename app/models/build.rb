class Build < ActiveRecord::Base
  attr_accessible :finished_at, :started_at, :status

  validates :job_id, presence: true

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
  def start
    update_attributes!(started_at: Time.now)
    update_attributes!(finished_at: Time.now, status: job.start)
  end
end
