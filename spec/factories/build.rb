require "factory_girl"

FactoryGirl.define do
  factory(:build) do
    job { FactoryGirl.create(:job) }
  end
end
