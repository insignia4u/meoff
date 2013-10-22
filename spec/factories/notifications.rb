FactoryGirl.define do
  factory :notification do
  	user
  	company

    :reason "Doctor Appointment"
    :scheduled_on 3.days.from_now
  end
end
