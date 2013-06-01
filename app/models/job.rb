class Job < PositiveRecord
  self.directory = Magi::Config.jobs_directory
end
