require 'rails_helper'

RSpec.describe RivalVictim, type: :model do

	it 'knows about its rival' do
		user1 = build_stubbed(:user)
		expect(build_stubbed(:rival_victim, rival: user1).rival).to eq(user1)
	end

	it 'knows about its victim' do
		user1 = build_stubbed(:user)
		expect(build_stubbed(:rival_victim, victim: user1).victim).to eq(user1)
	end

	it 'validates thet the rival and victim are not identical' do
		user1 = create(:user)
		expect(build(:rival_victim, rival: user1, victim: user1).save).to eq(false)
	end

	it 'validates that an identical RivalVictim relationship does not already exist' do
		rival_victim1 = create(:rival_victim)
		expect(build(:rival_victim, rival: rival_victim1.rival, victim: rival_victim1.victim).save).to eq(false)
	end

	it 'allows a victim to declare a rivalry against its rival' do
		rival_victim1 = create(:rival_victim)
		expect(build(:rival_victim, rival: rival_victim1.victim, victim: rival_victim1.rival).save).to eq(true)
	end

	it 'validates that the rival is not a fan of the victim' do
	fan_idol1 = create(:fan_idol)
		expect(build(:rival_victim, rival: fan_idol1.fan, victim: fan_idol1.idol).save).to eq(false)
	end

	it 'allows an idol to victimize their fan' do
		fan_idol1 = create(:fan_idol)
		expect(build(:rival_victim, rival: fan_idol1.idol, victim: fan_idol1.fan).save).to eq(true)
	end

end
