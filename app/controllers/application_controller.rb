class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :json

  self.responder = Magi::Responder

  rescue_from WeakParameters::ValidationError do
    head 400
  end
end
