class BuildWorker
  @queue = name

  class << self
    def perform(id)
      Build.find(id).start
    end

    def perform_async(id)
      Resque.enqueue(self, id)
    end
  end
end
