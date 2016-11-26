FactoryGirl.define do
	factory :user do
		sequence(:username) { |n| "lair00#{n}" }
		sequence(:email) { |n| "#{username}@example.com" }
		password "password"
		created_at { 10.days.ago }
		updated_at { Time.now }

		trait :true_random do
			username { fake_username }
			email { "#{username}@#{fake_domain}" }
			password { fake_password }
			created_at { Faker::Time.between(5.years.ago, 10.days.ago, :all) }
			updated_at { Faker::Time.between(4.days.ago, Time.now, :all) }
		end

		trait :random do
			username { fake_username }
			email { "#{username}@#{fake_domain}" }
			created_at { Faker::Time.between(5.years.ago, 10.days.ago, :all) }
			updated_at { Faker::Time.between(4.days.ago, Time.now, :all) }
		end

		trait :banned do
			role 'banned'
		end

		trait :administrator do
			role 'administrator'
		end

		trait :moderator do
			role 'moderator'
		end

		trait :superuser do
			role 'superuser'
		end

	end
end