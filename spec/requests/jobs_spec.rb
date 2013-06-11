require "spec_helper"

describe "Jobs" do
  let(:params) do
    {}
  end

  let(:env) do
    { "HTTP_ACCEPT" => "application/json" }
  end

  let(:job) do
    FactoryGirl.create(:job)
  end

  describe "GET /jobs" do
    before do
      job
    end

    it "returns jobs", :autodoc do
      get "/jobs", params, env
      response.status.should == 200
      response.body.should be_json([Hash])
    end
  end

  describe "GET /jobs/:id" do
    it "returns the job", :autodoc do
      get "/jobs/#{job.id}", params, env
      response.status.should == 200
      response.body.should be_json(Hash)
    end
  end

  describe "POST /jobs" do
    before do
      params[:name] = "name"
      params[:description] = "description"
    end

    context "with invalid params" do
      before do
        params.delete(:name)
      end

      it "returns 400" do
        post "/jobs", params, env
        response.status.should == 400
      end
    end

    context "with valid condition" do
      it "creates a new job", :autodoc do
        post "/jobs", params, env
        response.status.should == 201
        job = Job.first
        job.name.should == "name"
        job.description.should == "description"
      end
    end
  end

  describe "PUT /jobs/:id" do
    before do
      params[:name] = "name"
      params[:description] = "description"
    end

    context "with valid condition" do
      it "updates the job", :autodoc do
        put "/jobs/#{job.id}", params, env
        response.status.should == 204
        job.reload
        job.name.should == "name"
        job.description.should == "description"
      end
    end
  end

  describe "DELETE /jobs/:id" do
    it "deletes the job" do
      delete "/jobs/#{job.id}", params, env
      response.status.should == 204
      Job.should_not be_exist(job.id)
    end
  end
end
