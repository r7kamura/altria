class JobsController < ApplicationController
  before_filter :require_resource_params, only: [:create, :update]

  def index
    respond_with Job.all
  end

  def show
    respond_with resource
  end

  def create
    respond_with Job.create(resource_params.slice(:config, :id, :script))
  end

  def update
    respond_with resource.update_attributes(resource_params.slice(:config, :script))
  end

  def destroy
    respond_with resource.destroy
  end

  private

  def resource
    Job.find(params[:id])
  end
end
