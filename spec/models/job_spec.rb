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
        job.should_receive(:system).with("true")
        job.start
      end
    end
  end
end
