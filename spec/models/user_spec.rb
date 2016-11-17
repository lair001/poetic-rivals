require 'rails_helper'

RSpec.describe User, type: :model do

	it 'knows its username' do 
		user1 = build_stubbed(:user, username: "Billy Bob")
		expect(user1.username).to eq("Billy Bob")
	end

	it 'validates for unique username' do
		user1 = create(:user, username: "Billy Bob")
		user2 = build(:user, username: "Billy Bob")
		expect(user2.save).to eq(false)
	end

	it 'validates that the username is not an email address' do 
		user1 = build(:user, username: "BillyBob@example.com")
		expect(user1.save).to eq(false)
	end

	it 'knows its email address' do 
		user1 = build_stubbed(:user, email: "BillyBob@example.com")
		expect(user1.email).to eq("BillyBob@example.com")
	end

	it 'validates for unique email address' do
		user1 = create(:user, email: "BillyBob@example.com")
		user2 = build(:user, email: "BillyBob@example.com")
		expect(user2.save).to eq(false)
	end

	it 'is a normal user by default' do
		user1 = build_stubbed(:user)
		expect_user_role_to_be(user1, :normal)
	end

	it 'knows whether it has been banned' do
		user1 = build_stubbed(:user, :banned)
		expect_user_role_to_be(user1, :banned)
	end

	it 'knows whether it is a moderator' do
		user1 = build_stubbed(:user, :moderator)
		expect_user_role_to_be(user1, :moderator)
	end

	it 'knows whether it is an administrator' do
		user1 = build_stubbed(:user, :administrator)
		expect_user_role_to_be(user1, :administrator)
	end

	it 'knows whether it is a superuser' do
		user1 = build_stubbed(:user, :superuser)
		expect_user_role_to_be(user1, :superuser)
	end

	it 'knows when it was created' do
		user = build(:user)
		expect(user.created_at).to be_a(Time)
		time = Time.now
		user.update(created_at: time)
		expect(user.created_at).to eq(time)
	end

	it 'knows when it was updated' do
		user = build(:user)
		user.update(attributes_for(:user))
		expect(user.updated_at).to be_a(Time)
		expect(user.updated_at).to be.>(user.created_at)
	end

end