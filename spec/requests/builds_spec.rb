require "spec_helper"

describe "Builds" do
  let(:params) do
    {}
  end

  let(:env) do
    { "HTTP_ACCEPT" => "application/json" }
  end

  let(:job) do
    FactoryGirl.create(:job, properties: { "script" => "true" })
  end

  let(:build) do
    FactoryGirl.create(:build, job: job)
  end

  describe "GET /jobs/:job_id/builds" do
    before do
      build
    end

    it "returns builds of the job", :autodoc do
      get "/jobs/#{job.id}/builds", params, env
      response.status.should == 200
      response.body.should be_json([Hash])
    end

    context "with page" do
      before do
        params[:page] = 2
        10.times { FactoryGirl.create(:build, job: job) }
      end

      it "paginates builds" do
        get "/jobs/#{job.id}/builds", params, env
        response.status.should == 200
        response.body.should be_json([Hash])
      end
    end
  end

  describe "GET /builds/:id" do
    it "returns the build", :autodoc do
      get "/builds/#{build.id}", params, env
      response.status.should == 200
      response.body.should be_json(Hash)
    end
  end

  describe "POST /jobs/:job_id/builds" do
    it "creates a new build and queue it", :autodoc do
      post "/jobs/#{job.id}/builds", params, env
      response.status.should == 201
      response.body.should be_json(Hash)
      job.builds.should have(1).builds
    end
  end

  describe "PUT /builds/:id" do
    before do
      params[:status] = 1
    end

    it "updates the build", :autodoc do
      put "/builds/#{build.id}", params, env
      response.status.should == 204
      build.reload.status.should == true
    end
  end

  describe "DELETE /builds/:id" do
    it "deletes the build", :autodoc do
      delete "/builds/#{build.id}", params, env
      response.status.should == 204
      Build.should have(0).build
    end
  end
end
