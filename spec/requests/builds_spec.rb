require "spec_helper"

describe "Builds" do
  let(:params) do
    {}
  end

  let(:env) do
    { "HTTP_ACCEPT" => "application/json" }
  end

  let(:job) do
    Job.create(id: "a")
  end

  let(:build) do
    job.builds.create(id: 1)
  end

  describe "GET /jobs/:job_id/builds" do
    before do
      build
    end

    it "returns builds of the job" do
      get "/jobs/#{job.id}/builds", params, env
      response.status.should == 200
      response.body.should be_json([Hash])
    end
  end
end
