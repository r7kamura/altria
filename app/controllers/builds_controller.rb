class BuildsController < ApplicationController
  before_filter :require_job
  before_filter :require_resource_params, only: :update

  def index
    respond_with scope
  end

  def show
    respond_with resource
  end

  def create
    resource = scope.create_with_queue
    respond_with resource, location: [@job, resource]
  end

  def update
    respond_with resource.update_attributes(resource_params.slice(:status))
  end

  def destroy
    respond_with resource.destroy
  end

  private

  def require_job
    @job = Job.find(params[:job_id])
  end

  def scope
    @job.builds
  end
end
