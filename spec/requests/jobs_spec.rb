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

    it "returns jobs" do
      get "/jobs", params, env
      response.status.should == 200
      response.body.should be_json([Hash])
    end
  end

  describe "GET /jobs/:id" do
    it "returns the job" do
      get "/jobs/#{job.id}", params, env
      response.status.should == 200
      response.body.should be_json(Hash)
    end
  end

  describe "POST /jobs" do
    before do
      params[:job] = {
        name: "name",
        script: "script",
      }
    end

    context "with invalid params" do
      before do
        params.delete(:job)
      end

      it "returns 400" do
        post "/jobs", params, env
        response.status.should == 400
      end
    end

    context "with valid condition" do
      it "creates a new job" do
        post "/jobs", params, env
        response.status.should == 201
        Job.count.should == 1
      end
    end
  end

  describe "PUT /jobs/:id" do
    before do
      params[:job] = { name: "name" }
    end

    context "with invalid params" do
      before do
        params.delete(:job)
      end

      it "returns 400" do
        put "/jobs/#{job.id}", params, env
        response.status.should == 400
      end
    end

    context "with valid condition" do
      it "updates the job" do
        put "/jobs/#{job.id}", params, env
        response.status.should == 204
        Job.first.name.should == params[:job][:name]
      end
    end
  end

  describe "DELETE /jobs/:id" do
    it "deletes the job" do
      delete "/jobs/#{job.id}", params, env
      response.status.should == 204
      Job.exists?(job.id).should == false
    end
  end
end
