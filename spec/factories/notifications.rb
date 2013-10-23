FactoryGirl.define do
  factory :notification do
  	user
  	company

    sequence(:reason) { |n| "Doctor Appointment ##{n}" }
    sequence(:scheduled_on) { |n| rand(1..100).days.from_now }
  end
end
