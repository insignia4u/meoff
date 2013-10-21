# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    reason "MyText"
    on "2013-10-18 18:41:45"
    user_id 1
  end
end
