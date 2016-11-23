require 'rails_helper'

RSpec.describe "VictimRivals", type: :request do

	describe "POST #{victim_rivals_path ":victim_id"}" do
		it "redirects to root if no previous path is set and RivalVictim is successfully created" do
			save_models user_a, user_b
			sign_in user_a
			expect(RivalVictim.all.count).to eq(0)
			post victim_rivals_path user_b
			expect(RivalVictim.all.count).to eq(1)
			expect_redirect
			expect_path(:root)
		end

		it "redirects to previous path if previous path is set and RivalVictim is successfully created" do
			save_models user_a, user_b
			sign_in user_a
			get aqm_path
			expect(RivalVictim.all.count).to eq(0)
			post victim_rivals_path user_b
			expect(RivalVictim.all.count).to eq(1)
			expect_redirect
			expect_path(:aqm)
		end

		it "redirects a banned user to root without creating a RivalVictim regardless of whether a previous path is set" do
			save_models banned, user
			sign_in banned
			expect(RivalVictim.all.count).to eq(0)
			post victim_rivals_path user
			expect(RivalVictim.all.count).to eq(0)
			expect_unauthorized_access
			get aqm_path
			post victim_rivals_path user
			expect(RivalVictim.all.count).to eq(0)
			expect_unauthorized_access
		end

	end

	describe "DELETE #{victim_rival_path ":victim_id", ":rival_id"}" do

		it 'redirects to root after destroying a RivalVictim if the user is destroying a RivalVictim where it is the rival and no previous path is set' do 
			save_models user
			rival_victim = create(:rival_victim, rival: user)
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(true)
			sign_in user
			delete victim_rival_path rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(false)
			expect_redirect
			expect_path(:root)
		end

		it 'redirects to the previous path after destroying a RivalVictim if the user is destroying a RivalVictim where it is the rival and a previous path is set' do 
			save_models user
			rival_victim = create(:rival_victim, rival: user)
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(true)
			sign_in user
			get aqm_path
			delete victim_rival_path rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(false)
			expect_redirect
			expect_path(:aqm)
		end

		it 'redirects to root without destroying a RivalVictim if the user is attempting to destroy a RivalVictim where it is the victim and no previous path is set' do 
			save_models user
			rival_victim = create(:rival_victim, victim: user)
			expect(RivalVictim.all.count).to eq(1)
			sign_in user
			delete victim_rival_path rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id
			expect(RivalVictim.all.count).to eq(1)
			expect_unauthorized_action
		end

		it 'redirects to root without destroying a RivalVictim if the user is attempting to destroy a RivalVictim where it is the victim and regardless of whether a previous path is set' do 
			save_models user
			rival_victim = create(:rival_victim, victim: user)
			expect(RivalVictim.all.count).to eq(1)
			sign_in user
			get aqm_path
			delete victim_rival_path rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id
			expect(RivalVictim.all.count).to eq(1)
			expect_unauthorized_action
		end

		it 'redirects to root without destroying a RivalVictim if signed in as a banned user even if the banned user is the rival of the RivalVictim and a previous path is set' do 
			save_models banned
			rival_victim = create(:rival_victim, rival: banned)
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(true)
			sign_in banned
			get aqm_path
			delete victim_rival_path rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(true)
			expect_unauthorized_access
		end

		it 'redirects to root without destroying a RivalVictim if not signed in even if a previous path is set' do
			rival_victim = create(:rival_victim)
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(true)
			get aqm_path
			delete victim_rival_path rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(true)
			expect_unauthorized_access
		end

		it 'allows an administrator to destroy any RivalVictims' do
			save_models user, administrator
			create(:rival_victim, rival: user)
			create(:rival_victim, victim: user)
			create(:rival_victim, rival: administrator)
			create(:rival_victim, victim: administrator)
			expect(RivalVictim.all.count).to eq(4)
			sign_in administrator
			get aqm_path
			RivalVictim.all.each do |rival_victim|
				delete victim_rival_path rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id
				expect_redirect
				expect_path(:aqm)
			end
			expect(RivalVictim.all.count).to eq(0)
		end

		it 'allows a superuser to destroy any RivalVictims' do
			save_models user, superuser
			create(:rival_victim, rival: user)
			create(:rival_victim, victim: user)
			create(:rival_victim, rival: superuser)
			create(:rival_victim, victim: superuser)
			expect(RivalVictim.all.count).to eq(4)
			sign_in superuser
			get aqm_path
			RivalVictim.all.each do |rival_victim|
				delete victim_rival_path rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id
				expect_redirect
				expect_path(:aqm)
			end
			expect(RivalVictim.all.count).to eq(0)
		end

	end

end
