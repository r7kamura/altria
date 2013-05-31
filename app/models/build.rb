class Build < ActiveRecord::Base
  attr_accessible :finished_at, :started_at, :status

  belongs_to :job, touch: true
end
