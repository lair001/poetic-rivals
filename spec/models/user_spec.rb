require 'rails_helper'

RSpec.describe User, type: :model do

	describe 'Instance' do

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

		it 'is a poet by default' do
			expect_user_role_to_be(build_stubbed(:user), :poet)
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

		it 'has many poem_voters' do
			user1 = create(:user)
			poem1 = create(:poem, author: user1)
			poem_voter1 = create(:poem_voter, :up, poem: poem1)
			poem_voter2 = create(:poem_voter, :down, poem: poem1)
			expect(user1.poem_voters).to contain_exactly(poem_voter1, poem_voter2)
		end

		it 'knows its poem count, upvote count, and downvote count' do
			save_models(user)
			number_of_poems = rand(1..15)
			upvotes_per_poem = rand(1..7)
			downvotes_per_poem = rand(1..7)
			build_poems_for(user, number_of_poems, upvotes_per_poem, downvotes_per_poem)
			user.save
			expect(user.poems_count).to eq(number_of_poems)
			expect(user.upvotes_count).to eq(number_of_poems * upvotes_per_poem)
			expect(user.downvotes_count).to eq(number_of_poems * downvotes_per_poem)
		end

		it 'knows its fan count' do
			save_models(user)
			number_of_fans = rand(1..15)
			build_fans_for(user, number_of_fans)
			user.save
			expect(user.fans_count).to eq(number_of_fans)
		end

		it 'knows its idol count' do
			save_models(user)
			number_of_idols = rand(1..15)
			build_idols_for(user, number_of_idols)
			user.save
			expect(user.idols_count).to eq(number_of_idols)
		end

		it 'knows its rival count' do
			save_models(user)
			number_of_rivals = rand(1..15)
			build_rivals_for(user, number_of_rivals)
			user.save
			expect(user.rivals_count).to eq(number_of_rivals)
		end

		it 'knows its fan count' do
			save_models(user)
			number_of_victims = rand(1..15)
			build_victims_for(user, number_of_victims)
			user.save
			expect(user.victims_count).to eq(number_of_victims)
		end

		it 'knows its poem score, relationship score, score, score per poem and can properly refresh its score' do
			user1 = create(:user)

			build_fans_for(user1, 4)
			build_rivals_for(user1, 3)
			build_poems_for(user1, 8, 3, 1)
			user1.save
			user1 = User.find(user1.id)

			expect(user1.poem_score).to eq(16)
			expect(user1.relationship_score).to eq(100)
			expect(user1.score).to eq(116)
			expect(user1.score_per_poem).to eq(14.5)

			user1.update(score: rand(-128..127))
			user1.refresh_score
			expect(user1.score).to eq(116)

			build_rivals_for(user1, 2)
			build_poems_for(user1, 1, 2, 8)
			user1.save
			user1 = User.find(user1.id)

			expect(user1.poem_score).to eq(10)
			expect(user1.relationship_score).to eq(-100)
			expect(user1.score).to eq(-90)
			expect(user1.score_per_poem).to eq(-10.0)

			user1.update(score: rand(-128..127))
			user1.refresh_score
			expect(user1.score).to eq(-90)
		end

		it 'knows who it is idolizing and victimizing' do
			save_models(user_a, user_b, user_c)
			create(:fan_idol, fan: user_a, idol: user_b)
			create(:rival_victim, rival: user_b, victim: user_c)
			expect(user_a.idolizing?(user_b)).to eq(true)
			expect(user_a.idolizing?(user_b)).to eq(true)
			expect(user_a.victimizing?(user_c)).to eq(false)
			expect(user_a.victimizing?(user_c)).to eq(false)
			expect(user_b.victimizing?(user_c)).to eq(true)
			expect(user_b.victimizing?(user_c)).to eq(true)
			expect(user_b.idolizing?(user_a)).to eq(false)
			expect(user_b.idolizing?(user_a)).to eq(false)
		end

		it 'knows which poems it is voting on' do
			save_models(user, poem_a, poem_b, poem_c)
			create(:poem_voter, :up, poem: poem_a, voter: user)
			create(:poem_voter, :down, poem: poem_c, voter: user)
			expect(user.voting_on?(poem_a)).to eq(true)
			expect(user.voting_on?(poem_a)).to eq(true)
			expect(user.voting_on?(poem_b)).to eq(false)
			expect(user.voting_on?(poem_b)).to eq(false)
			expect(user.voting_on?(poem_c)).to eq(true)
			expect(user.voting_on?(poem_c)).to eq(true)
		end

		it 'knows which poems it can view' do
			save_models(user, banned, administrator, moderator, superuser)
			poem_1 = create(:poem)
			poem_2 = create(:poem, :private)
			poem_3 = create(:poem, :private, author: user)
			poem_4 = create(:poem, :private, author: administrator)

			expect(banned.can_view?(poem_1)).to eq(false)
			expect(banned.can_view?(poem_2)).to eq(false)
			expect(banned.can_view?(poem_3)).to eq(false)
			expect(banned.can_view?(poem_4)).to eq(false)

			expect(user.can_view?(poem_1)).to eq(true)
			expect(user.can_view?(poem_2)).to eq(false)
			expect(user.can_view?(poem_3)).to eq(true)
			expect(user.can_view?(poem_4)).to eq(false)

			expect(administrator.can_view?(poem_1)).to eq(true)
			expect(administrator.can_view?(poem_2)).to eq(false)
			expect(administrator.can_view?(poem_3)).to eq(false)
			expect(administrator.can_view?(poem_4)).to eq(true)

			expect(moderator.can_view?(poem_1)).to eq(true)
			expect(moderator.can_view?(poem_2)).to eq(true)
			expect(moderator.can_view?(poem_3)).to eq(true)
			expect(moderator.can_view?(poem_4)).to eq(true)

			expect(superuser.can_view?(poem_1)).to eq(true)
			expect(superuser.can_view?(poem_2)).to eq(true)
			expect(superuser.can_view?(poem_3)).to eq(true)
			expect(superuser.can_view?(poem_4)).to eq(true)
		end

	end

	describe 'Class' do

		it 'knows the users with the highest and lowest scores and the most fans and rivals' do
			save_models user_a, user_b, user_c

			build_fans_for(user_a, 7)
			build_rivals_for(user_a, 3)
			build_poems_for(user_a, 8, 3, 1)
			user_a.save #score: 316

			build_fans_for(user_b, 4)
			build_rivals_for(user_b, 5)
			build_poems_for(user_b, 9, 3, 1)
			user_b.save #score: -82

			build_fans_for(user_c, 5)
			build_rivals_for(user_c, 3)
			build_poems_for(user_c, 10, 3, 1)
			user_c.save #score: 220

			expect(User.with_highest_score).to eq(user_a)
			expect(User.with_lowest_score).to eq(user_b)
			expect(User.with_most_fans).to eq(user_a)
			expect(User.with_most_rivals).to eq(user_b)

		end

		it 'knows the users with the most idols and victims' do
			save_models user_a, user_b, user_c

			build_idols_for(user_a, 3)
			build_victims_for(user_a, 2)
			user_a.save

			build_idols_for(user_b, 2)
			build_victims_for(user_b, 1)
			user_b.save

			build_idols_for(user_c, 1)
			build_victims_for(user_c, 3)
			user_c.save

			expect(User.with_most_idols).to eq(user_a)
			expect(User.with_most_victims).to eq(user_c)
		end

	end

end