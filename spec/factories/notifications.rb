FactoryGirl.define do
  factory :notification do
  	user
  	company

    sequence(:reason) { |n| "Doctor Appointment" }
    sequence(:scheduled_on) { |n| 3.days.from_now }
  end
end
