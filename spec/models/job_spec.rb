require "spec_helper"

describe Job do
  let(:job) do
    FactoryGirl.create(:job, properties: { "script" => "true" })
  end

  describe "#start" do
    context "without script" do
      before do
        job.script = nil
      end

      it "raises Job::ScriptNotFound" do
        expect { job.start }.to raise_error(Job::ScriptNotFound)
      end
    end

    context "with script" do
      before do
        job.script = "true"
      end

      it "starts its job" do
        Magi::Executer.should_receive(:execute).with("true")
        job.start
      end
    end
  end

  describe "#scheduled?" do
    context "without schedule" do
      it "returns false" do
        job.should_not be_scheduled
      end
    end

    context "with empty schedule" do
      before do
        job.schedule = ""
      end

      it "returns false" do
        job.should_not be_scheduled
      end
    end

    context "with matched schedule" do
      before do
        job.schedule = "* * * * *"
      end

      it "returns true" do
        job.should be_scheduled
      end
    end

    context "without matched schedule" do
      before do
        job.schedule = "0 0 0 0 0"
      end

      it "returns false" do
        job.should_not be_scheduled
      end
    end
  end

  describe "#enqueue" do
    before do
      Job.before_enqueues.clear
    end

    after do
      Job.before_enqueues.clear
    end

    context "with successful hooks" do
      before do
        Job.before_enqueue { Job.hook_is_executed }
      end

      it "enqueues a new build" do
        Job.should_receive(:hook_is_executed)
        job.enqueue
      end
    end

    context "with failed hooks" do
      before do
        Job.before_enqueue { false }
        Job.before_enqueue { Job.hook_is_executed }
      end

      it "stops at failed hook" do
        Job.should_not_receive(:hook_is_executed)
        job.enqueue
      end
    end
  end
end
