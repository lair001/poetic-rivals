require 'rails_helper'

RSpec.describe "PoemVoters", type: :request do

	describe "POST #{poem_voters_path ":poem_id"}" do
		it "redirects to root if no previous path is set and PoemVoter is successfully created" do
			save_models user, poem
			sign_in user
			expect(PoemVoter.all.count).to eq(0)
			post poem_voters_path(poem), params: { value: random_poem_voter_value }
			expect(PoemVoter.all.count).to eq(1)
			expect_redirect
			expect_path(:root)
		end

		it "redirects to previous path if previous path is set and PoemVoter is successfully created" do
			save_models user, poem
			sign_in user
			get aqm_path
			expect(PoemVoter.all.count).to eq(0)
			post poem_voters_path(poem), params: { value: random_poem_voter_value }
			expect(PoemVoter.all.count).to eq(1)
			expect_redirect
			expect_path(:aqm)
		end

		it "redirects a banned user to root without creating a PoemVoter regardless of whether a previous path is set" do
			save_models banned, user
			sign_in banned
			expect(PoemVoter.all.count).to eq(0)
			post poem_voters_path user
			expect(PoemVoter.all.count).to eq(0)
			expect_unauthorized_access
			get aqm_path
			post poem_voters_path user
			expect(PoemVoter.all.count).to eq(0)
			expect_unauthorized_access
		end

	end

	describe "DELETE #{poem_voter_path ":poem_id", ":voter_id"}" do

		it 'redirects to root after destroying a PoemVoter if the user is destroying a PoemVoter where it is the voter and no previous path is set' do 
			save_models user
			poem_voter = create(:poem_voter, random_poem_voter_value_trait, voter: user)
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			sign_in user
			delete poem_voter_path voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(false)
			expect_redirect
			expect_path(:root)
		end

		it 'redirects to the previous path after destroying a PoemVoter if the user is destroying a PoemVoter where it is the voter and a previous path is set' do 
			save_models user
			poem_voter = create(:poem_voter, random_poem_voter_value_trait, voter: user)
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			sign_in user
			get aqm_path
			delete poem_voter_path voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(false)
			expect_redirect
			expect_path(:aqm)
		end

		it 'redirects to root without destroying a PoemVoter if the user is attempting to destroy a PoemVoter where it is not the voter and no previous path is set' do 
			save_models user_a, user_b
			poem_voter = create(:poem_voter, random_poem_voter_value_trait, voter: user_b)
			expect(PoemVoter.all.count).to eq(1)
			sign_in user_a
			delete poem_voter_path voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id
			expect(PoemVoter.all.count).to eq(1)
			expect_unauthorized_action
		end

		it 'redirects to root without destroying a PoemVoter if the user is attempting to destroy a PoemVoter where it is not the voter and regardless of whether a previous path is set' do 
			save_models user_a, user_b
			poem_voter = create(:poem_voter, random_poem_voter_value_trait, voter: user_b)
			expect(PoemVoter.all.count).to eq(1)
			sign_in user_a
			get aqm_path
			delete poem_voter_path voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id
			expect(PoemVoter.all.count).to eq(1)
			expect_unauthorized_action
		end

		it 'redirects to root without destroying a PoemVoter if signed in as a banned user even if the banned user is the voter of the PoemVoter and a previous path is set' do 
			save_models banned
			poem_voter = create(:poem_voter, random_poem_voter_value_trait, voter: banned)
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			sign_in banned
			get aqm_path
			delete poem_voter_path voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			expect_unauthorized_access
		end

		it 'redirects to root without destroying a PoemVoter if not signed in even if a previous path is set' do
			poem_voter = create(:poem_voter, random_poem_voter_value_trait)
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			get aqm_path
			delete poem_voter_path voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id
			expect(PoemVoter.exists?(voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id)).to be(true)
			expect_unauthorized_access
		end

		it 'allows an administrator to destroy any PoemVoters' do
			save_models user, administrator
			create(:poem_voter, random_poem_voter_value_trait, voter: user)
			create(:poem_voter, random_poem_voter_value_trait, voter: administrator)
			expect(PoemVoter.all.count).to eq(2)
			sign_in administrator
			get aqm_path
			PoemVoter.all.each do |poem_voter|
				delete poem_voter_path voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id
				expect_redirect
				expect_path(:aqm)
			end
			expect(PoemVoter.all.count).to eq(0)
		end

		it 'allows a superuser to destroy any PoemVoters' do
			save_models user, superuser
			create(:poem_voter, random_poem_voter_value_trait, voter: user)
			create(:poem_voter, random_poem_voter_value_trait, voter: superuser)
			expect(PoemVoter.all.count).to eq(2)
			sign_in superuser
			get aqm_path
			PoemVoter.all.each do |poem_voter|
				delete poem_voter_path voter_id: poem_voter.voter_id, poem_id: poem_voter.poem_id
				expect_redirect
				expect_path(:aqm)
			end
			expect(PoemVoter.all.count).to eq(0)
		end

	end

end