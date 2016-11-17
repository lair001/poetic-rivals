FactoryGirl.define do
  factory :poem do
    title fake_title
    body fake_two_paragraphs
    association :author, factory: :user
  end

  trait :private do
  	private? true
  end
end
