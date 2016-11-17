require 'rails_helper'

RSpec.describe Genre, type: :model do

	it 'knows its name' do
		genre = fake_genre
		expect(build(:genre, name: genre).name).to eq(genre)
	end

	it "isn't banned by default" do
		expect(build(:genre).banned?).to eq(false)
	end

	it "knows if it has been banned" do
		expect(build(:genre, banned?: true).banned?).to eq(true)
	end

	it 'has many poems' do
		genre1 = create(:genre)
		poem1 = create(:poem)
		poem2 = create(:poem)
		genre1.poems.push(poem1, poem2)
		genre1.save
		expect(genre1.poems).to include(poem1, poem2)
	end

end
