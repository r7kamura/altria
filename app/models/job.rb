require "tempfile"

class Job < ActiveRecord::Base
  attr_accessible :name, :config

  serialize :config, Hash

  validates :name, presence: true

  has_many :builds

  scope :alphabetical, -> { order("name") }

  def start
    if has_script?
      invoke
    else
      raise ScriptNotFound
    end
  end

  def script
    config["script"]
  end

  def has_script?
    !!script
  end

  def invoke
    temp = Tempfile.new("")
    status = system(script, out: temp, err: temp)
    temp.close
    { status: status, output: temp.open.read }
  end

  class ScriptNotFound < StandardError; end
end
