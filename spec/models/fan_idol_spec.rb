require 'rails_helper'

RSpec.describe FanIdol, type: :model do

	it 'knows about its fan' do
		user1 = build_stubbed(:user)
		expect(build_stubbed(:fan_idol, fan: user1).fan).to eq(user1)
	end

	it 'knows about its idol' do
		user1 = build_stubbed(:user)
		expect(build_stubbed(:fan_idol, idol: user1).idol).to eq(user1)
	end

	it 'validates that the fan and idol are not identical' do
		user1 = create(:user)
		expect(build(:fan_idol, fan: user1, idol: user1).save).to eq(false)
	end

	it 'validates that an identical FanIdol relationship does not already exist' do
		fan_idol1 = create(:fan_idol)
		expect(build(:fan_idol, fan: fan_idol1.fan, idol: fan_idol1.idol).save).to eq(false)
	end

	it 'allows an idol to idolize its fan' do
		fan_idol1 = create(:fan_idol)
		expect(build(:fan_idol, fan: fan_idol1.idol, idol: fan_idol1.fan).save).to eq(true)
	end

	it 'validates that the fan is not a rival of the idol' do
		rival_victim1 = create(:rival_victim)
		expect(build(:fan_idol, fan: rival_victim1.rival, idol: rival_victim1.victim).save).to eq(false)
	end

	it 'allows a victim to idolize their rival' do
		rival_victim1 = create(:rival_victim)
		expect(build(:fan_idol, fan: rival_victim1.victim, idol: rival_victim1.rival).save).to eq(true)
	end

end
