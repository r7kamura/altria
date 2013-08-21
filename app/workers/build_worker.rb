class BuildWorker
  @queue = name

  class << self
    def perform(id)
      Build.find(id).run
    end

    def perform_async(id)
      Resque.enqueue(self, id)
    end

    def on_failure(*args)
      id = args[1]
      message = args[0].message
      Build.find(id).update_attributes!(finished_at: Time.now, output: message, status: false)
    end
  end
end
