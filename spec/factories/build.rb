require "factory_girl"

FactoryGirl.define do
  factory(:build) do
    job { FactoryGirl.create(:job) }
    started_at { Time.now }
    finished_at { Time.now }
  end
end
