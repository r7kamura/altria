class BuildsController < ApplicationController
  before_filter :require_job, only: [:index, :create]
  before_filter :require_resources, only: :index
  before_filter :require_resource, only: [:show, :update, :destroy]

  validates :update do
    integer :status
  end

  def index
    respond_with @resources
  end

  def show
    respond_with @resource, layout: !request.xhr?
  end

  def create
    respond_with @job.enqueue
  end

  def update
    respond_with @resource.update_attributes(params.permit(:status))
  end

  def destroy
    respond_with @resource.destroy
  end

  private

  def require_job
    @job = Job.find(params[:job_id])
  end

  def scope
    @job.builds
  end

  def require_resources
    @resources = @job.builds
  end

  def require_resource
    @resource = Build.find(params[:id])
  end
end
