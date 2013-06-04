require "spec_helper"

describe Job do
  let(:job) do
    FactoryGirl.create(:job)
  end

  describe "#start" do
    context "without script" do
      it "raises Job::ScriptNotFound" do
        expect { job.start }.to raise_error(Job::ScriptNotFound)
      end
    end

    context "with script" do
      before do
        job.config["script"] = "true"
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

    context "with matched schedule" do
      before do
        job.config["schedule"] = "* * * * *"
      end

      it "returns true" do
        job.should be_scheduled
      end
    end

    context "without matched schedule" do
      before do
        job.config["schedule"] = "0 0 0 0 0"
      end

      it "returns false" do
        job.should_not be_scheduled
      end
    end
  end
end
