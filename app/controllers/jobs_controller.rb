class JobsController < ApplicationController
  before_filter :require_resources, only: :index
  before_filter :require_resource, only: [:show, :edit, :update, :destroy]

  validates :create do
    string :name, required: true
    hash :config
  end

  validates :update do
    string :name
    hash :config
  end

  def index
    respond_with @resources
  end

  def show
    respond_with @resource
  end

  def new
    respond_with @resource = scope.new
  end

  def create
    respond_with @resource = scope.create_with_properties(params.slice(:config, :name))
  end

  def update
    respond_with @resource.update_attributes_with_properties(params.slice(:config, :name))
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
