require File.expand_path("../../config/environment.rb", __FILE__)

Clockwork.every(1.minute, "JobEnqueueWorker") do
  Job.enqueue_with_before_hooks
end
