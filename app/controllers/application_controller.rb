class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :json

  self.responder = Altria::Responder

  rescue_from WeakParameters::ValidationError do
    head 400
  end

  # Cache to use `view_context.content_for` from controller.
  # This hack is nice to hook view_context from a plugin.
  #
  # Examples
  #
  #   JobsController.before_filter do
  #     view_context.content_for :jobs_show, "This is a footer."
  #   end
  #
  def view_context
    @view_context ||= super
  end
end
