FactoryGirl.define do
  factory :poem_voter do
    poem
    association :voter, factory: :user

    trait :up do
    	value 1
    end

    trait :down do
    	value(-1)
    end

  end
end
