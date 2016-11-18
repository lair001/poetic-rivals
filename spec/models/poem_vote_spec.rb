require 'rails_helper'

RSpec.describe PoemVote, type: :model do

	it 'knows its poem' do
		poem = build_stubbed(:poem)
		expect(build_stubbed(:poem_vote, :up, poem: poem).poem).to eq(poem)
	end

	it 'knows its value' do
		expect(build_stubbed(:poem_vote, :up).value).to eq(1)
		expect(build_stubbed(:poem_vote, :down).value).to eq(-1)
	end

	it 'validates that it has a poem' do
		expect(build(:poem_vote, :up, poem: nil).save).to eq(false)
	end

	it 'validates that it does not share its poem with another vote' do
		poem_vote1 = create(:poem_vote, :up)
		expect(build(:poem_vote, :up, poem: poem_vote1.poem).save).to eq(false)
		expect(build(:poem_vote, :down, poem: poem_vote1.poem).save).to eq(false)
	end

	it 'validates that its value is either -1 or 1' do
		expect(build(:poem_vote, :up).save).to eq(true)
		expect(build(:poem_vote, :down).save).to eq(true)
		expect(build(:poem_vote, value: rand(2..127)).save).to eq(false)
		expect(build(:poem_vote, value: rand(-128..-2)).save).to eq(false)
	end

end
