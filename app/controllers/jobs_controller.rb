class JobsController < ApplicationController
  def index
    respond_with scope
  end

  def show
    respond_with scope.find(params[:id])
  end

  def create
    respond_with scope.create(params[:job])
  end

  def update
    respond_with scope.find(params[:id]).update(params[:job])
  end

  def destroy
    respond_with scope.find(params[:id]).destroy
  end

  private

  def scope
    Job.scoped
  end
end
