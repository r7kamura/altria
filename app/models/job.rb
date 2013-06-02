class Job < PositiveRecord::Base
  self.directory = Magi::Config.jobs_directory

  validates :id, presence: true

  property :id

  has_many :builds

  def new_build(attributes = {})
    Build.new(attributes.merge(job_id: id))
  end

  def create_build(attributes = {})
    attributes[:id] = next_build_id
    new_build(attributes).tap(&:save)
  end

  private

  def next_build_id
    builds.count + 1
  end
end
