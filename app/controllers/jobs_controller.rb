class JobsController < ApplicationController
  def index
    respond_with Job.scoped
  end

  def show
    respond_with Job.find(params[:id])
  end

  def create
    respond_with Job.create(params[:job])
  end

  def update
    respond_with Job.find(params[:id]).update(params[:job])
  end

  def destroy
    respond_with Job.find(params[:id]).destroy
  end
end
