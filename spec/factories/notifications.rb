FactoryGirl.define do
  factory :notification do
  	user
  	company

    sequence(:reason) { |n| "Doctor Appointment ##{n}" }
    sequence(:scheduled_on) { |n| n.days.from_now }
  end
end
