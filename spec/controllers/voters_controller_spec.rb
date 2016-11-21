require 'rails_helper'

RSpec.describe VotersController, type: :controller do

	describe "#create" do
		it 'creates a new PoemVoter if signed in as a user who is not banned and the resulting PoemVoter is successfully saved' do
			save_models user_a, poem
			expect(PoemVoter.all.where(voter_id: user_a.id, poem_id: poem.id).count).to eq(0)
			sign_in user_a
			post :create, params: { value: random_poem_voter_value, poem_id: poem.id }
			expect(PoemVoter.all.where(voter_id: user_a.id, poem_id: poem.id).first).to be_a(PoemVoter)
		end

		it 'does not create a new PoemVoter if signed in as a user who is not banned and the resulting PoemVoter is not successfully saved' do
			save_models user
			expect(PoemVoter.all.count).to eq(0)
			sign_in user
			begin
				post :create, params: { value: random_poem_voter_value, poem_id: user.id + 1 }
			rescue NameError
			end
			expect(PoemVoter.all.count).to eq(0)
			begin
				post :create, params: { value: random_poem_voter_value, poem_id: '' }
			rescue NameError
			end
			expect(PoemVoter.all.count).to eq(0)
			post :create, params: { value: random_poem_voter_value, poem_id: user.id }
			expect(PoemVoter.all.count).to eq(0)
		end

		it 'does not create a new PoemVoter if signed in as a user who is banned' do
			save_models banned, user
			expect(PoemVoter.all.count).to eq(0)
			sign_in banned
			post :create, params: { value: random_poem_voter_value, poem_id: user.id }
			expect(PoemVoter.all.count).to eq(0)
		end

		it 'does not create a new PoemVoter if not signed in' do
			save_models user
			expect(PoemVoter.all.count).to eq(0)
			post :create, params: { value: random_poem_voter_value, poem_id: user.id }
			expect(PoemVoter.all.count).to eq(0)
		end

	end

	describe "#destroy" do

		it 'allows a user to destroy PoemVoters where it is the voter' do
			save_models user
			poem_voter = create(:poem_voter, random_poem_voter_value_trait, voter: user)
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			sign_in user
			delete :destroy, params: { voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id }
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(false)
		end

		it 'does not allow a banned user to destroy PoemVoters even when it is the voter' do
			save_models banned
			poem_voter = create(:poem_voter, random_poem_voter_value_trait, voter: banned)
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			sign_in banned
			delete :destroy, params: { voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id }
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
		end

		it 'does not allow destruction of PoemVoters if not signed in' do
			poem_voter = create(:poem_voter, random_poem_voter_value_trait)
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			delete :destroy, params: { voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id }
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
		end

		it 'does not allow a user to destroy PoemVoters where it is not the voter' do
			save_models user_a
			poem_voter = create(:poem_voter, random_poem_voter_value_trait, voter: user_b)
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			sign_in user_a
			delete :destroy, params: { voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id }
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
		end

		it 'allows an administrator to destroy any PoemVoters' do
			save_models user, administrator
			create(:poem_voter, random_poem_voter_value_trait, voter: user)
			create(:poem_voter, random_poem_voter_value_trait, voter: administrator)
			expect(PoemVoter.all.count).to eq(2)
			sign_in administrator
			PoemVoter.all.each { |poem_voter| delete :destroy, params: { voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id } }
			expect(PoemVoter.all.count).to eq(0)
		end

		it 'allows a superuser to destroy any PoemVoters' do
			save_models user, superuser
			create(:poem_voter, random_poem_voter_value_trait, voter: user)
			create(:poem_voter, random_poem_voter_value_trait, voter: superuser)
			expect(PoemVoter.all.count).to eq(2)
			sign_in superuser
			PoemVoter.all.each { |poem_voter| delete :destroy, params: { voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id } }
			expect(PoemVoter.all.count).to eq(0)
		end

	end
end