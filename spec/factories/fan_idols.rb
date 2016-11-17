FactoryGirl.define do
  factory :fan_idol do
    association :fan, factory: :user
    association :idol, factory: :user
  end
end
