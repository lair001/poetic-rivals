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

end
