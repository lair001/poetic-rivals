require 'rails_helper'

RSpec.describe User, type: :model do

	it 'knows its username' do 
		username = fake_username
		expect(build_stubbed(:user, username: username).username).to eq(username)
	end

	it 'validates for unique username' do
		username = fake_username
		create(:user, username: username)
		expect(build(:user, username: username).save).to eq(false)
	end

	it 'validates that the username is not an email address' do
		email = fake_email
		expect(build(:user, username: email).save).to eq(false)
	end

	it 'knows its email address' do
		email = fake_email
		expect(build_stubbed(:user, email: email).email).to eq(email)
	end

	it 'validates for unique email address' do
		email = fake_email
		create(:user, email: email)
		expect(build(:user, email: email).save).to eq(false)
	end

	it 'has an encrypted password' do
		password = fake_password
		user1 = create(:user, password: password)
		user1 = User.find(user1.id)
		expect(user1.password).to eq(nil)
		expect(user1.encrypted_password).to be_a(String)
		expect(user1.encrypted_password).to_not eq("")
		expect(user1.encrypted_password).to_not eq(password)
	end

	it 'is a normal user by default' do
		expect_user_role_to_be(build_stubbed(:user), :normal)
	end

	it 'knows whether it has been banned' do
		expect_user_role_to_be(build_stubbed(:user, :banned), :banned)
	end

	it 'knows whether it is a moderator' do
		expect_user_role_to_be(build_stubbed(:user, :moderator), :moderator)
	end

	it 'knows whether it is an administrator' do
		expect_user_role_to_be(build_stubbed(:user, :administrator), :administrator)
	end

	it 'knows whether it is a superuser' do
		expect_user_role_to_be(build_stubbed(:user, :superuser), :superuser)
	end

	it 'knows when it was created' do
		user1 = build(:user)
		expect(user1.created_at).to be_a(Time)
		time = Time.now
		user1.update(created_at: time)
		expect(user1.created_at).to eq(time)
	end

	it 'knows when it was updated' do
		user1 = build(:user)
		user1.update(attributes_for(:user))
		expect(user1.updated_at).to be_a(Time)
		expect(user1.updated_at).to be.>(user1.created_at)
	end

	it 'has many poems' do
		user1 = create(:user)
		poem1 = create(:poem, author: user1)
		poem2 = create(:poem, author: user1)
		user1 = User.find(user1.id)
		expect(user1.poems).to contain_exactly(poem1, poem2)
	end

	it 'has many genres' do
  		user1 = create(:user)
  		poem1 = create(:poem, author: user1)
		genre1 = create(:genre)
		genre2 = create(:genre)
		poem1.genres.push(genre1, genre2)
		poem1.save
		poem2 = create(:poem, author: user1)
		genre3 = create(:genre)
		genre4 = create(:genre)
		poem2.genres.push(genre2, genre3, genre4)
		poem2.save
		expect(user1.genres).to contain_exactly(genre1, genre2, genre3, genre4)
	end

	it 'has many commentaries' do
		user1 = create(:user)
		commentary1 = create(:commentary, commentator: user1)
		commentary2 = create(:commentary, commentator: user1)
		expect(user1.commentaries).to contain_exactly(commentary1, commentary2)
	end

	it 'has many commentators' do
		user1 = create(:user)
		user2 = create(:user)
		user3 = create(:user)
		user4 = create(:user)
		poem1 = create(:poem, author: user1)
		poem2 = create(:poem, author: user1)
		create(:commentary, poem: poem2, commentator: user2)
		create(:commentary, poem: poem2, commentator: user2)
		create(:commentary, poem: poem1, commentator: user3)
		create(:commentary, poem: poem2, commentator: user3)
		create(:commentary, poem: poem1, commentator: user4)
		expect(user1.commentators).to contain_exactly(user2, user3, user4)
	end

	it 'has many fans' do
		user1 = create(:user)
		user2 = create(:user)
		user3 = create(:user)
		user1.fans.push(user2, user3)
		expect(user1.fans).to contain_exactly(user2, user3)
	end

	it 'has many idols' do
		user1 = create(:user)
		user2 = create(:user)
		user3 = create(:user)
		user1.idols.push(user2, user3)
		expect(user1.idols).to contain_exactly(user2, user3)
	end

	it 'has many rivals' do
		user1 = create(:user)
		user2 = create(:user)
		user3 = create(:user)
		user1.rivals.push(user2, user3)
		expect(user1.rivals).to contain_exactly(user2, user3)
	end

	it 'has many victims' do
		user1 = create(:user)
		user2 = create(:user)
		user3 = create(:user)
		user1.victims.push(user2, user3)
		expect(user1.victims).to contain_exactly(user2, user3)
	end

	it 'knows its score' do
		user1 = create(:user)

		3.times do
			user1.rivals.build(attributes_for :user)
		end

		4.times do
			user1.fans.build(attributes_for :user)
		end

		user1.save
		expect(user1.score).to eq(100)
	end

	it 'knows its score per poem' do
		user1 = create(:user)

		3.times do
			user1.rivals.build(attributes_for :user)
		end

		4.times do
			user1.fans.build(attributes_for :user)
		end

		8.times do
			user1.poems.build(attributes_for :poem)
		end

		user1.save
		expect(user1.score_per_poem).to eq(12.5)
	end

end