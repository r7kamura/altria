require "action_controller"

module Magi
  class Responder < ActionController::Responder
    def initialize(controller, resources, *args)
      if resources[0].is_a?(Array)
        resources[0] = resources[0].page(controller.params[:page])
      end
      super
    end
  end
end
