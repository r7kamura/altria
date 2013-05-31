class BuildsController < ApplicationController
  before_filter :require_job

  def index
    respond_with scope
  end

  def show
    respond_with scope.find(params[:id])
  end

  def create
    respond_with scope.create(params[:build])
  end

  def update
    respond_with scope.find(params[:id]).update(params[:build])
  end

  def destroy
    respond_with scope.find(params[:id]).destroy
  end

  private

  def require_job
    @job = Job.find(params[:job_id])
  end

  def scope
    @job.builds
  end
end
