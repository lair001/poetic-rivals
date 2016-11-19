FactoryGirl.define do
  factory :commentary do
    comment { fake_n_paragraphs(rand(1..10)) }
    poem
    association :commentator, factory: :user
  end
end
