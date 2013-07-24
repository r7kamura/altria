class Build < ActiveRecord::Base
  include Altria::Proprietary

  serialize :properties, Hash

  validates :job_id, presence: true

  belongs_to :job, touch: true, counter_cache: true

  scope :recent, -> { order("created_at DESC") }

  scope :finished, -> { where("finished_at IS NOT NULL") }

  scope :unfinished, -> { where("finished_at IS NULL") }

  scope :started, -> { where("started_at IS NOT NULL") }

  scope :running, -> { started.unfinished }

  after_create { update_incremental_id }

  validate :one_job_cannot_have_more_than_two_builds, on: :create

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

  def notify(type)
    $redis.publish("build.#{type}", notified_data)
  end

  def notified_data
    { id: id, job_id: job.id, status: status_name, finished_at: finished_at }.to_json
  end

  def start
    update_attributes!(started_at: Time.now)
    notify(:started)
  end

  def finish(result)
    reload.update_attributes!(finished_at: Time.now, output: result[:output], status: result[:status])
    notify(:finished)
  end

  def update_incremental_id
    update_attributes(incremental_id: job.builds.count)
  end

  private

  def one_job_cannot_have_more_than_two_builds
    if job.builds.unfinished.any?
      errors.add(:id, "One job cannot have more than two builds")
    end
  end
end
