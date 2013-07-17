require "spec_helper"

describe Altria::Command do
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
        command.should_receive(:system).with(
          %W[
            cd #{Dir.pwd} &&
            bundle install &&
            bundle exec rake db:create &&
            bundle exec rake db:migrate
          ].join(" ")
        )
        command.call
      end
    end

    context "with `start`" do
      let(:arguments) do
        ["start"]
      end

      it "executes start script" do
        command.should_receive(:system).with("cd #{Dir.pwd} && bundle exec foreman start")
        command.call
      end
    end

    context "with unknown arguments" do
      let(:arguments) do
        []
      end

      it "shows usage" do
        command.should_receive(:puts).with("Usage: altria {setup|start}")
        command.call
      end
    end
  end
end
