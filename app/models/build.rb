class Build < ActiveRecord::Base
  attr_accessible :finished_at, :started_at, :output, :status

  validates :job_id, presence: true

  belongs_to :job, touch: true

  scope :recent, -> { order("id DESC") }

  # Pushes this build to worker's queue.
  def queue
    BuildWorker.perform_async(id)
  end

  # Runs this build, usually called from BuildWorker#perform.
  def start
    update_attributes!(started_at: Time.now)
    result = job.start
    update_attributes!(finished_at: Time.now, status: result[:status], output: result[:output])
  end

  # Returns elapsed sec as a Float or nil.
  def sec
    finished_at - started_at if finished_at && started_at
  end
end
