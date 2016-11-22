FactoryGirl.define do
  factory :poem do
    title { fake_poem_title }
    body { fake_poem_body }
    association :author, factory: :user
  end

  trait :private do
  	private? true
  end
end
