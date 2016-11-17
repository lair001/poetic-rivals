FactoryGirl.define do
	factory :user do
		sequence(:username) { |n| "lair00#{n}" }
		sequence(:email) { |n| "lair00#{n}@example.com" }
		password "password"
		created_at { 10.days.ago }
		updated_at { Time.now }

		trait :banned do
			role 'banned'
		end

		trait :admininistrator do
			role 'admininistrator'
		end

		trait :moderator do
			role 'moderator'
		end

		trait :superuser do
			role 'superuser'
		end

	end
end