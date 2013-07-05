class JobsController < ApplicationController
  before_filter :require_resources, only: :index
  before_filter :require_resource, only: [:show, :edit, :update, :destroy]

  validates :create do
    string :name, required: true
  end

  validates :update do
    string :name
  end

  def index
    respond_with @resources
  end

  def show
    respond_with @resource, layout: !request.xhr?
  end

  def new
    respond_with @resource = scope.new
  end

  def create
    respond_with @resource = scope.create_with_properties(params)
  end

  def update
    respond_with @resource.update_attributes_with_properties(params)
  end

  def destroy
    respond_with @resource.destroy
  end

  private

  def scope
    Job.all
  end

  def require_resources
    @resources = scope
  end

  def require_resource
    @resource = scope.find(params[:id])
  end
end
