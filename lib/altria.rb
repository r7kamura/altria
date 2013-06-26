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
