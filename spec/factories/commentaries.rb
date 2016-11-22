FactoryGirl.define do
  factory :commentary do
    comment { fake_commentary_comment }
    poem
    association :commentator, factory: :user
  end
end
