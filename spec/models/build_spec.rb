require "spec_helper"

describe Build do
  let(:build) do
    FactoryGirl.create(:build, job: job)
  end

  let(:job) do
    FactoryGirl.create(:job, config: { "script" => "true" })
  end

  describe "#start" do
    context "with success" do
      it "starts its job and sets status with true" do
        build.start
        build.started_at.should be_present
        build.finished_at.should be_present
        build.status.should == true
      end
    end

    context "with failure" do
      before do
        build.job.config["script"] = "false"
      end

      it "starts its job and sets status with false" do
        build.start
        build.started_at.should be_present
        build.finished_at.should be_present
        build.status.should == false
      end
    end
  end
end
