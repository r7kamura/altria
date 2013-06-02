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

  describe "GET /jobs/:job_id/builds/:id" do
    it "returns the build" do
      get "/jobs/#{job.id}/builds/#{build.id}", params, env
      response.status.should == 200
      response.body.should be_json(Hash)
    end
  end

  describe "POST /jobs/:job_id/builds" do
    it "creates a new build and queue it" do
      post "/jobs/#{job.id}/builds", params, env
      response.status.should == 201
      response.body.should be_json(Hash)
      BuildWorker.jobs.should have(1).queue
    end
  end

  describe "PUT /jobs/:job_id/builds/:id" do
    before do
      params[:build] = { status: true }
    end

    it "updates the build" do
      put "/jobs/#{job.id}/builds/#{build.id}", params, env
      response.status.should == 204
      build.reload.status.should == true
    end
  end

  describe "DELETE /jobs/:job_id/builds/:id" do
    it "updates the build" do
      delete "/jobs/#{job.id}/builds/#{build.id}", params, env
      response.status.should == 204
      Build.should have(0).build
    end
  end
end
