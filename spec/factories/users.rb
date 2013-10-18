FactoryGirl.define do
  factory :user do
  	company

  	sequence(:email) { |n| "johndoe-#{n}@meoff.com" }
  	sequence(:full_name) { |n| "John Doe ##{n}" }
  	
  	password              "123123123"
  	password_confirmation "123123123"

  	trait :confirmed do
      after(:create) { |user| user.confirm! }
    end
  end
end
