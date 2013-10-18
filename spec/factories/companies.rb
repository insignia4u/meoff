FactoryGirl.define do
  factory :company do
  	sequence(:name) { |n| "MeOff Inc ##{n}" }
  end
end
