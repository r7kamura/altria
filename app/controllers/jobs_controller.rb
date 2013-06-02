class JobsController < ApplicationController
  before_filter :require_resource_params, only: [:create, :update]

  def index
    respond_with scope
  end

  def show
    respond_with resource
  end

  def create
    respond_with scope.create(resource_params.slice(:config, :name))
  end

  def update
    respond_with resource.update_attributes(resource_params.slice(:config, :name))
  end

  def destroy
    respond_with resource.destroy
  end

  private

  def scope
    Job.scoped
  end

  def resource
    Job.find(params[:id])
  end
end
