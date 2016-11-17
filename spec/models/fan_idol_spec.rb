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

end
