require "magi/command"
require "magi/configuration"
require "magi/responder"
require "magi/version"
require "magi/workspace"

module Magi
  class << self
    def configuration
      @configuration ||= Magi::Configuration.new
    end
  end
end
