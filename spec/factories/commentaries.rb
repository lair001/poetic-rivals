FactoryGirl.define do
  factory :commentary do
    comment { fake_two_paragraphs }
    poem
    association :commentator, factory: :user
  end
end
