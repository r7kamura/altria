class Job < ActiveRecord::Base
  attr_accessible :name, :config

  serialize :config, Hash

  validates :name, presence: true

  has_many :builds

  def start
    if script
      system(script)
    else
      raise ScriptNotFound
    end
  end

  def script
    config["script"]
  end

  class ScriptNotFound < StandardError; end
end
