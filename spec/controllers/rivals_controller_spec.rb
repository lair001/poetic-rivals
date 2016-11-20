require 'rails_helper'

RSpec.describe RivalsController, type: :controller do

	describe "#create" do
		it 'creates a new RivalVictim if signed in as a user who is not banned and the resulting RivalVictim is successfully saved' do
			save_models user_a, user_b
			expect(RivalVictim.all.where(rival_id: user_a.id, victim_id: user_b.id).count).to eq(0)
			sign_in user_a
			get :create, params: { victim_id: user_b.id }
			expect(RivalVictim.all.where(rival_id: user_a.id, victim_id: user_b.id).first).to be_a(RivalVictim)
		end

		it 'does not create a new RivalVictim if signed in as a user who is not banned and the resulting RivalVictim is not successfully saved' do
			save_models user
			expect(RivalVictim.all.count).to eq(0)
			sign_in user
			begin
				get :create, params: { victim_id: user.id + 1 }
			rescue NameError
			end
			expect(RivalVictim.all.count).to eq(0)
			begin
				get :create, params: { victim_id: '' }
			rescue NameError
			end
			expect(RivalVictim.all.count).to eq(0)
			get :create, params: { victim_id: user.id }
			expect(RivalVictim.all.count).to eq(0)
		end

		it 'does not create a new RivalVictim if signed in as a user who is banned' do
			save_models banned, user
			expect(RivalVictim.all.count).to eq(0)
			sign_in banned
			get :create, params: { victim_id: user.id }
			expect(RivalVictim.all.count).to eq(0)
		end
	end

	describe "#create" do

		it 'allows a user to destroy RivalVictims where it is the rival' do
			save_models user
			rival_victim = create(:rival_victim, rival: user)
			sign_in user
			get :destroy, params: { rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id }
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(false)
		end

		it 'does not allow a user to destroy RivalVictims where it is the victim' do
			save_models user
			rival_victim = create(:rival_victim, victim: user)
			sign_in user
			get :destroy, params: { rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id }
			expect(RivalVictim.exists?(rival_id: rival_victim.rival_id, victim_id: rival_victim.victim_id)).to be(true)
		end


	end

end
