FactoryGirl.define do
  factory :poem do
    title Faker::Lorem.sentence.chomp(".").titleize
    body Faker::Lorem.paragraphs(2)
    association :author, factory: :user
  end

  trait :private do
  	private? true
  end
end
