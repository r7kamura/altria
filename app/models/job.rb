class Job < ActiveRecord::Base
  attr_accessible :config, :name, :script

  has_many :builds

  # We allow users to store arbitrary data to config column in key-value format.
  # Hash is a simple and lightweight way to do it.
  serialize :config, Hash

  validates :name, presence: true

  # Runs its script and returns the status as a Boolean.
  def run
    system(script)
  end
end
