FactoryGirl.define do
  factory :poem_vote do
    poem

    trait :up do
    	value 1
    end

    trait :down do
    	value(-1)
    end

  end
end
