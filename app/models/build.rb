class Build < ActiveRecord::Base
  include Magi::Proprietary

  attr_accessible :finished_at, :started_at, :output, :properties, :status

  serialize :properties, Hash

  validates :job_id, presence: true

  belongs_to :job, touch: true

  scope :recent, -> { order("created_at DESC") }

  scope :finished, -> { where("finished_at IS NOT NULL") }

  scope :unfinished, -> { where("finished_at IS NULL") }

  scope :started, -> { where("started_at IS NOT NULL") }

  scope :running, -> { started.unfinished }

  paginates_per 10

  def self.latest
    recent.first
  end

  # Pushes this build to worker's queue.
  def enqueue
    BuildWorker.perform_async(id)
  end

  # Runs this build, usually called from BuildWorker#perform.
  def run
    start
    finish(job.run)
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

  private

  def start
    update_attributes!(started_at: Time.now)
  end

  def finish(result)
    reload.update_attributes!(
      finished_at: Time.now,
      output: result[:output],
      status: result[:status],
    )
  end
end
