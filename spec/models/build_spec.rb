require "spec_helper"

describe Build do
  let(:build) do
    FactoryGirl.create(:build, job: job)
  end

  let(:job) do
    FactoryGirl.create(:job, properties: { "script" => "true" })
  end

  describe "#run" do
    context "with success" do
      it "runs its job and sets status with true" do
        build.run
        build.started_at.should be_present
        build.finished_at.should be_present
        build.status.should == true
      end
    end

    context "with failure" do
      before do
        build.job.script = "false"
      end

      it "runs its job and sets status with false" do
        build.run
        build.started_at.should be_present
        build.finished_at.should be_present
        build.status.should == false
      end
    end
  end
end
