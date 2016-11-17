FactoryGirl.define do
  factory :rival_victim do
    association :rival, factory: :user
    association :victim, factory: :user
  end
end
