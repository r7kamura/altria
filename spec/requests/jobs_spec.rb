require "spec_helper"

describe "Jobs" do
  let(:params) do
    {}
  end

  let(:env) do
    { "HTTP_ACCEPT" => "application/json" }
  end

  let(:job) do
    Job.create(id: "a")
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
        id: "a",
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

    context "with invalid attributes" do
      before do
        params[:job].delete(:id)
      end

      it "returns 422" do
        post "/jobs", params, env
        response.status.should == 422
      end
    end

    context "with valid condition" do
      it "creates a new job" do
        post "/jobs", params, env
        response.status.should == 201
        Job.find(params[:job][:id])[:script].should == "script"
      end
    end
  end

  describe "PUT /jobs/:id" do
    before do
      params[:job] = { script: "ls" }
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
        job.reload[:script].should == params[:job][:script]
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
