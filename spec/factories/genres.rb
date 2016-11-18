FactoryGirl.define do
  factory :genre do
    name { fake_genre }
    banned? false
  end
end
