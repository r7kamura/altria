class Job < PositiveRecord
  self.directory = Magi::Config.jobs_directory

  validates :id, presence: true

  property :id

  def new_build(attributes = {})
    Build.new(attributes.merge(job_id: id))
  end

  def create_build(attributes = {})
    attributes[:id] = next_build_id
    new_build(attributes).tap(&:save)
  end

  def builds_count
    build_pathnames.count
  end

  def builds
    build_pathnames.map do |pathname|
      attributes = YAML.load_file(pathname)
      Build.new(attributes)
    end
  end

  def build_pathnames
    Pathname.glob("#{builds_directory}/*/attributes.yml")
  end

  def builds_directory
    pathname.dirname.join("builds")
  end

  private

  def next_build_id
    builds_count + 1
  end
end
