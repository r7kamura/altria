class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :json

  rescue_from WeakParameters::ValidationError do
    head 400
  end

  self.responder = Magi::Responder

  private

  def require_resource_params
    head 400 unless resource_params
  end

  def resource_name
    self.class.name.split("::").last.sub(/Controller$/, "").singularize.underscore
  end

  def resource_params
    params[resource_name]
  end
end
