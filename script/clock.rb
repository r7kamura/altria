require File.expand_path("../../config/environment.rb", __FILE__)

Clockwork.every(1.minute, "JobEnqueueWorker") do
  Job.scheduled.each(&:enqueue_with_before_enqueues)
end
