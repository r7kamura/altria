require "spec_helper"

describe "Builds" do
  let(:params) do
    {}
  end

  let(:env) do
    { "HTTP_ACCEPT" => "application/json" }
  end

  let(:job) do
    FactoryGirl.create(:job)
  end

  let(:build) do
    FactoryGirl.create(:build, job: job)
  end

  describe "GET /jobs/:job_id/builds" do
    before do
      build
    end

    it "returns builds" do
      get "/jobs/#{job.id}/builds", params, env
      response.status.should == 200
      response.body.should be_json([Hash])
    end
  end

  describe "GET /jobs/:job_id/builds/:id" do
    it "returns the build" do
      get "/jobs/#{job.id}/builds/#{build.id}", params, env
      response.status.should == 200
      response.body.should be_json(Hash)
    end
  end
end
