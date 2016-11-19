FactoryGirl.define do
  factory :poem do
    title { fake_title }
    body { fake_n_paragraphs(rand(1..10)) }
    association :author, factory: :user
  end

  trait :private do
  	private? true
  end
end
