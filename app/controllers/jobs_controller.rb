class JobsController < ApplicationController
  before_filter :require_resource_params, only: [:create, :update]
  before_filter :require_resources, only: :index
  before_filter :require_resource, only: [:show, :update, :destroy]

  def index
    respond_with @resources
  end

  def show
    respond_with @resource
  end

  def create
    respond_with scope.create(resource_params.slice(:config, :name))
  end

  def update
    respond_with @resource.update_attributes(resource_params.slice(:config, :name))
  end

  def destroy
    respond_with @resource.destroy
  end

  private

  def scope
    Job.scoped
  end

  def require_resources
    @resources = scope
  end

  def require_resource
    @resource = scope.find(params[:id])
  end
end
