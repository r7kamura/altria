class Job < ActiveRecord::Base
  attr_accessible :config, :name, :script

  # We allow users to store arbitrary data to config column in key-value format.
  # Hash is a simple and lightweight way to do it.
  serialize :config, Hash

  validates :name, presence: true
end
