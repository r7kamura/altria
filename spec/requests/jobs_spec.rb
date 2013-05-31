require "spec_helper"

describe "Jobs" do
  let(:params) do
    {}
  end

  let(:env) do
    { "HTTP_ACCEPT" => "application/json" }
  end

  describe "GET /jobs" do
    it "returns jobs" do
      get "/jobs", params, env
      response.body.should be_json([])
    end
  end

  describe "POST /jobs" do
    before do
      params[:job] = {
        name: "name",
        script: "script",
      }
    end

    context "without valid params" do
      before do
        params.delete(:job)
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
      end
    end
  end
end
