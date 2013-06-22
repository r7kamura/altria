require "spec_helper"

describe Magi::Command do
  let(:command) do
    described_class.new(arguments)
  end

  describe ".call" do
    it "delegates to #call" do
      described_class.any_instance.should_receive(:call)
      described_class.call(["setup"])
    end
  end

  describe "#call" do
    context "with `setup`" do
      let(:arguments) do
        ["setup"]
      end

      it "executes setup script" do
        command.should_receive(:system).with("cd #{Dir.pwd} && rake db:create db:migrate")
        command.call
      end
    end

    context "with `start`" do
      let(:arguments) do
        ["start"]
      end

      it "executes start script" do
        command.should_receive(:system).with({ "WORKSPACE_PATH" => Dir.pwd }, "cd #{Dir.pwd} && foreman start")
        command.call
      end
    end

    context "with unknown arguments" do
      let(:arguments) do
        []
      end

      it "shows usage" do
        command.should_receive(:puts).with("Usage: magi {setup|start}")
        command.call
      end
    end
  end
end
