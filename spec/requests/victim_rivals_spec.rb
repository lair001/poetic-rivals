require 'rails_helper'

RSpec.describe "VictimRivals", type: :request do
	describe "post #{victim_rivals_path ":victim_id"}" do
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
end
