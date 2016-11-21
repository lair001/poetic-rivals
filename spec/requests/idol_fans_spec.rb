require 'rails_helper'

RSpec.describe "IdolFans", type: :request do

	describe "POST #{idol_fans_path ":idol_id"}" do
		it "redirects to root if no previous path is set and FanIdol is successfully created" do
			save_models user_a, user_b
			sign_in user_a
			expect(FanIdol.all.count).to eq(0)
			post idol_fans_path user_b
			expect(FanIdol.all.count).to eq(1)
			expect_redirect
			expect_path(:root)
		end

		it "redirects to previous path if previous path is set and FanIdol is successfully created" do
			save_models user_a, user_b
			sign_in user_a
			get aqm_path
			expect(FanIdol.all.count).to eq(0)
			post idol_fans_path user_b
			expect(FanIdol.all.count).to eq(1)
			expect_redirect
			expect_path(:aqm)
		end

		it "redirects a banned user to root without creating a FanIdol regardless of whether a previous path is set" do
			save_models banned, user
			sign_in banned
			expect(FanIdol.all.count).to eq(0)
			post idol_fans_path user
			expect(FanIdol.all.count).to eq(0)
			expect_unauthorized_access
			get aqm_path
			post idol_fans_path user
			expect(FanIdol.all.count).to eq(0)
			expect_unauthorized_access
		end

	end

	describe "DELETE #{idol_fan_path ":idol_id", ":fan_id"}" do

		it 'redirects to root after destroying a FanIdol if the user is destroying a FanIdol where it is the fan and no previous path is set' do 
			save_models user
			fan_idol = create(:fan_idol, fan: user)
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			sign_in user
			delete idol_fan_path fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(false)
			expect_redirect
			expect_path(:root)
		end

		it 'redirects to the previous path after destroying a FanIdol if the user is destroying a FanIdol where it is the fan and a previous path is set' do 
			save_models user
			fan_idol = create(:fan_idol, fan: user)
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			sign_in user
			get aqm_path
			delete idol_fan_path fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(false)
			expect_redirect
			expect_path(:aqm)
		end

		it 'redirects to root without destroying a FanIdol if the user is attempting to destroy a FanIdol where it is the idol and no previous path is set' do 
			save_models user
			fan_idol = create(:fan_idol, idol: user)
			expect(FanIdol.all.count).to eq(1)
			sign_in user
			delete idol_fan_path fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id
			expect(FanIdol.all.count).to eq(1)
			expect_unauthorized_action
		end

		it 'redirects to the previous without destroying a FanIdol if the user is attempting to destroy a FanIdol where it is the idol and a previous path is set' do 
			save_models user
			fan_idol = create(:fan_idol, idol: user)
			expect(FanIdol.all.count).to eq(1)
			sign_in user
			get aqm_path
			delete idol_fan_path fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id
			expect(FanIdol.all.count).to eq(1)
			expect_unauthorized_action
		end

		it 'redirects to root without destroying a FanIdol if signed in as a banned user even if the banned user is the fan of the FanIdol and a previous path is set' do 
			save_models banned
			fan_idol = create(:fan_idol, fan: banned)
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			sign_in banned
			get aqm_path
			delete idol_fan_path fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			expect_unauthorized_access
		end

		it 'redirects to root without destroying a FanIdol if not signed in even if a previous path is set' do
			fan_idol = create(:fan_idol)
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			get aqm_path
			delete idol_fan_path fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			expect_unauthorized_access
		end

		it 'allows an administrator to destroy any FanIdols' do
			save_models user, administrator
			create(:fan_idol, fan: user)
			create(:fan_idol, idol: user)
			create(:fan_idol, fan: administrator)
			create(:fan_idol, idol: administrator)
			expect(FanIdol.all.count).to eq(4)
			sign_in administrator
			get aqm_path
			FanIdol.all.each do |fan_idol|
				delete idol_fan_path fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id
				expect_redirect
				expect_path(:aqm)
			end
			expect(FanIdol.all.count).to eq(0)
		end

		it 'allows a superuser to destroy any FanIdols' do
			save_models user, superuser
			create(:fan_idol, fan: user)
			create(:fan_idol, idol: user)
			create(:fan_idol, fan: superuser)
			create(:fan_idol, idol: superuser)
			expect(FanIdol.all.count).to eq(4)
			sign_in superuser
			get aqm_path
			FanIdol.all.each do |fan_idol|
				delete idol_fan_path fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id
				expect_redirect
				expect_path(:aqm)
			end
			expect(FanIdol.all.count).to eq(0)
		end

	end

end