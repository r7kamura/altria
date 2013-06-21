require "json"
require "fileutils"

module Magi
  class SimpleCov
    attr_reader :job

    def initialize(job)
      @job = job
    end

    def after_execute
      save if enabled? && has_coverage?
    end

    def enabled?
      job.enable_simplecov == "1"
    end

    def workspace_path
      job.workspace.path + "coverage"
    end

    def last_coverage
      JSON.parse(last_run_json)["result"]["covered_percent"]
    rescue JSON::ParserError, NoMethodError
    end

    def last_run_json
      last_run_json_path.read
    end

    def has_last_run_json?
      last_run_json_path.exist?
    end

    def has_coverage?
      has_last_run_json?
    end

    def last_run_json_path
      job.repository.path + "coverage/.last_run.json"
    end

    def assets_path
      job.repository.path + "coverage/assets"
    end

    def assets_relative_path
      assets_path.relative_path_from(current_build_path)
    end

    def result_html_path
      job.repository.path + "coverage/index.html"
    end

    def current_build_path
      workspace_path + job.current_build.id.to_s
    end

    def symlink_assets
      File.symlink(assets_relative_path, current_build_path + "assets")
    end

    def copy_result_html
      FileUtils.cp(result_html_path, current_build_path)
    end

    def save
      current_build_path.mkpath
      symlink_assets
      copy_result_html
    end
  end
end

Job.class_eval do
  property(:enable_simplecov, type: :boolean)

  after_execute { coverage.after_execute }

  def coverage
    @coverage ||= Magi::SimpleCov.new(self)
  end
end
