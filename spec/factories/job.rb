require "factory_girl"

FactoryGirl.define do
  factory(:job) do
    sequence(:name) {|n| "name #{n}" }
  end
end
