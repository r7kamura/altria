class Build < ActiveRecord::Base
  extend Magi::Proprietary

  attr_accessible :finished_at, :started_at, :output, :properties, :status

  serialize :properties

  validates :job_id, presence: true

  belongs_to :job, touch: true

  scope :recent, -> { order("created_at DESC") }

  scope :finished, -> { where("finished_at IS NOT NULL") }

  # Pushes this build to worker's queue.
  def enqueue
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

  def status_name
    case status
    when true
      "success"
    when false
      "failure"
    when nil
      "unfinished"
    end
  end
end
