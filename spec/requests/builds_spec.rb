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

  describe "POST /jobs/:job_id/builds" do
    it "creates a new build" do
      post "/jobs/#{job.id}/builds", params, env
      response.status.should == 201
      response.body.should be_json(Hash)
      Build.count.should == 1
      BuildWorker.jobs.size.should == 1
    end
  end

  describe "PUT /jobs/:job_id/builds/:id" do
    before do
      params[:build] = { status: 1 }
    end

    context "with invalid params" do
      before do
        params.delete(:build)
      end

      it "returns 400" do
        put "/jobs/#{job.id}/builds/#{build.id}", params, env
        response.status.should == 400
      end
    end

    context "with valid condition" do
      it "updates the build" do
        put "/jobs/#{job.id}/builds/#{build.id}", params, env
        response.status.should == 204
        build.reload.status.should == 1
      end
    end
  end

  describe "DELETE /jobs/:job_id/builds/:id" do
    it "deletes the build" do
      delete "/jobs/#{job.id}/builds/#{build.id}", params, env
      response.status.should == 204
      Build.exists?(build.id).should == false
    end
  end
end
