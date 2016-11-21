require 'rails_helper'

RSpec.describe FansController, type: :controller do

	describe "#create" do
		it 'creates a new FandIdol if signed in as a user who is not banned and the resulting FanIdol is successfully saved' do
			save_models user_a, user_b
			expect(FanIdol.all.where(fan_id: user_a.id, idol_id: user_b.id).count).to eq(0)
			sign_in user_a
			post :create, params: { idol_id: user_b.id }
			expect(FanIdol.all.where(fan_id: user_a.id, idol_id: user_b.id).first).to be_a(FanIdol)
		end

		it 'does not create a new FanIdol if signed in as a user who is not banned and the resulting FanIdol is not successfully saved' do
			save_models user
			expect(FanIdol.all.count).to eq(0)
			sign_in user
			begin
				post :create, params: { idol_id: user.id + 1 }
			rescue NameError
			end
			expect(FanIdol.all.count).to eq(0)
			begin
				post :create, params: { idol_id: '' }
			rescue NameError
			end
			expect(FanIdol.all.count).to eq(0)
			post :create, params: { idol_id: user.id }
			expect(FanIdol.all.count).to eq(0)
		end

		it 'does not create a new FanIdol if signed in as a user who is banned' do
			save_models banned, user
			expect(FanIdol.all.count).to eq(0)
			sign_in banned
			post :create, params: { idol_id: user.id }
			expect(FanIdol.all.count).to eq(0)
		end

		it 'does not create a new FanIdol if not signed in' do
			save_models user
			expect(FanIdol.all.count).to eq(0)
			post :create, params: { idol_id: user.id }
			expect(FanIdol.all.count).to eq(0)
		end

	end

	describe "#destroy" do

		it 'allows a user to destroy FanIdols where it is the fan' do
			save_models user
			fan_idol = create(:fan_idol, fan: user)
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			sign_in user
			delete :destroy, params: { fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id }
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(false)
		end

		it 'does not allow a banned user to destroy FanIdols even when it is the fan' do
			save_models banned
			fan_idol = create(:fan_idol, fan: banned)
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			sign_in banned
			delete :destroy, params: { fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id }
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
		end

		it 'does not allow destruction of FanIdols if not signed in' do
			fan_idol = create(:fan_idol)
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			delete :destroy, params: { fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id }
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
		end

		it 'does not allow a user to destroy FanIdols where it is the idol' do
			save_models user
			fan_idol = create(:fan_idol, idol: user)
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
			sign_in user
			delete :destroy, params: { fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id }
			expect(FanIdol.exists?(fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id)).to be(true)
		end

		it 'allows an administrator to destroy any FanIdols' do
			save_models user, administrator
			create(:fan_idol, fan: user)
			create(:fan_idol, idol: user)
			create(:fan_idol, fan: administrator)
			create(:fan_idol, idol: administrator)
			expect(FanIdol.all.count).to eq(4)
			sign_in administrator
			FanIdol.all.each { |fan_idol| delete :destroy, params: { fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id } }
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
			FanIdol.all.each { |fan_idol| delete :destroy, params: { fan_id: fan_idol.fan_id, idol_id: fan_idol.idol_id } }
			expect(FanIdol.all.count).to eq(0)
		end

	end
end