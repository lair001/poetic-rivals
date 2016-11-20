require 'rails_helper'

RSpec.describe RivalsController, type: :controller do

	describe "#create" do
		it 'creates a new RivalVictim if signed in as a user who is not banned' do
			save_models user_a, user_b
			expect(RivalVictim.all.where(rival_id: user_a.id, victim_id: user_b.id).count).to eq(0)
			sign_in user_a
			get :create, params: { victim_id: user_b.id }
			expect(RivalVictim.all.where(rival_id: user_a.id, victim_id: user_b.id).first).to be_a(RivalVictim)
		end

		it 'does not create a new RivalVictim if signed in as a user who is banned' do
			save_models banned, user
			expect(RivalVictim.all.where(rival_id: banned.id, victim_id: user.id).count).to eq(0)
			sign_in banned
			get :create, params: { victim_id: user.id }
			expect(RivalVictim.all.where(rival_id: banned.id, victim_id: user.id).count).to eq(0)
		end
	end

end
