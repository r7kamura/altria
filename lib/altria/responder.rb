require "action_controller"

module Altria
  class Responder < ActionController::Responder
    def initialize(controller, resources, *args)
      if resources[0].respond_to?(:page)
        resources[0] = resources[0].page(controller.params[:page])
      end
      super
    end
  end
end
