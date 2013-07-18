$LOAD_PATH.unshift File.expand_path("..", __FILE__)

require "altria/command"
require "altria/configuration"
require "altria/responder"
require "altria/version"
require "altria/workspace"

module Altria
  class << self
    def configuration
      @configuration ||= Altria::Configuration.new
    end
  end
end
