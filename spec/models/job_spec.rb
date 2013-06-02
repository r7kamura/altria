require "spec_helper"

describe Job do
  let(:job) do
    Job.create(id: "a", script: "script")
  end

  describe ".new" do
    it "takes a Hash as its attributes" do
      Job.new(id: "a")[:id].should == "a"
    end
  end

  describe ".find" do
    before do
      job
    end

    context "with existent filename" do
      it "returns a Job" do
        Job.find("a").should be_a Job
      end
    end

    context "with non-existent filename " do
      it "raises a RecordNotFound error" do
        expect { Job.find("non-existent") }.to raise_error PositiveRecord::RecordNotFound
      end
    end
  end

  describe ".scoped" do
    it "returns PositiveRecord::Relation" do
      Job.scoped.should be_a PositiveRecord::Relation
    end
  end

  describe ".all" do
    before do
      job
    end

    it "returns all files under the directory as an Array of Pathname" do
      Job.all.should have(1).job
    end
  end

  describe ".create" do
    it "creates a new Job with a YAML file" do
      Job.create(id: "created").pathname.should be_exist
    end
  end

  describe ".exists?" do
    it "returns if a file with given id exists or not" do
      Job.exists?("a").should == false
      job
      Job.exists?("a").should == true
    end
  end

  describe "#destroy" do
    it "destroys its file" do
      job = Job.create(id: "created")
      job.destroy
      job.pathname.should_not be_exist
    end
  end

  describe "#==" do
    context "when its pathname is identical" do
      it "returns true" do
        (job == Job.find("a")).should == true
      end
    end

    context "when its pathname is not identical" do
      it "returns false" do
        (job == Job.create(id: "b")).should == false
      end
    end
  end

  describe "#to_hash" do
    it "represents its content as Hash" do
      job.to_hash.should == { "id" => "a", "script" => "script" }
    end
  end

  describe "#update_attributes" do
    it "updates its attributes and file" do
      job.update_attributes(script: "updated")
      job[:script].should == "updated"
      job.reload[:script].should == "updated"
    end
  end

  describe "#new_build" do
    it "initializes a new build" do
      build = job.new_build
      build.should be_a Build
      build.should_not be_persisted
    end
  end

  describe "#create_build" do
    it "creates a new build" do
      build = job.create_build
      build.should be_a Build
      build.should be_persisted
    end
  end

  describe "#builds" do
    it "returns an Array of associated Build" do
      job.builds.should be_a PositiveRecord::Relation
    end
  end

  describe "#persisted?" do
    it "returns if its file is persisted or not" do
      job = Job.new(id: "a")
      job.should_not be_persisted
      job.save
      job.should be_persisted
    end
  end

  describe "#method_missing" do
    context "with property's name" do
      it "returns its property value" do
        job.id
      end
    end

    context "without property's name" do
      it "raises NoMethodError" do
        expect { job.foo }.to raise_error(NoMethodError)
      end
    end
  end
end
