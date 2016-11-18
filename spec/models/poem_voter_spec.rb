require 'rails_helper'

RSpec.describe PoemVoter, type: :model do

	it 'knows its poem' do
		poem = build_stubbed(:poem)
		expect(build_stubbed(:poem_voter, :up, poem: poem).poem).to eq(poem)
	end

	it 'knows its voter' do
		user1 = build_stubbed(:user)
		expect(build_stubbed(:poem_voter, :up, voter: user1).voter).to eq(user1)
	end

	it 'knows its value' do
		expect(build_stubbed(:poem_voter, :up).value).to eq(1)
		expect(build_stubbed(:poem_voter, :down).value).to eq(-1)
	end

	it 'validates that it has a poem' do
		expect(build(:poem_voter, :up, poem: nil).save).to eq(false)
	end

	it 'validates that it has a voter' do
		expect(build(:poem_voter, :up, voter: nil).save).to eq(false)
	end

	it 'validates that its value is either -1 or 1' do
		expect(build(:poem_voter, :up).save).to eq(true)
		expect(build(:poem_voter, :down).save).to eq(true)
		expect(build(:poem_voter, value: rand(2..127)).save).to eq(false)
		expect(build(:poem_voter, value: rand(-128..-2)).save).to eq(false)
	end

	it 'validates that a voter does not vote for the same poem more than once' do
		poem_voter1 = create(:poem_voter, :up)
		expect(build(:poem_voter, :up, poem: poem_voter1.poem, voter: poem_voter1.voter).save).to eq(false)
		expect(build(:poem_voter, :down, poem: poem_voter1.poem, voter: poem_voter1.voter).save).to eq(false)
		expect(build(:poem_voter, :up, poem: poem_voter1.poem).save).to eq(true)
		expect(build(:poem_voter, :down, poem: poem_voter1.poem).save).to eq(true)
		expect(build(:poem_voter, :up, voter: poem_voter1.voter).save).to eq(true)
		expect(build(:poem_voter, :down, voter: poem_voter1.voter).save).to eq(true)
	end

	it 'validates that a voter does not vote for his or her own poem' do
		user1 = create(:user)
		poem1 = create(:poem, author: user1)
		poem2 = create(:poem, author: user1)
		expect(build(:poem_voter, :up, poem: poem1, voter: user1).save).to eq(false)
		expect(build(:poem_voter, :down, poem: poem2, voter: user1).save).to eq(false)
	end

end
