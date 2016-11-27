require 'rails_helper'

RSpec.describe Genre, type: :model do

	it 'knows its name' do
		genre = fake_genre
		expect(build_stubbed(:genre, name: genre).name).to eq(genre)
	end

	it 'it validates its name for uniqueness regardless of letter case' do
		save_models genre
		expect(build(:genre, name: genre.name.upcase).save).to eq(false)
		expect(build(:genre, name: genre.name.downcase).save).to eq(false)
	end

	it "isn't banned by default" do
		expect(build_stubbed(:genre).banned?).to eq(false)
	end

	it "knows if it has been banned" do
		expect(build_stubbed(:genre, banned?: true).banned?).to eq(true)
	end

	it 'has many poems and knows its poems count' do
		save_models genre
		poem_1 = create(:poem)
		poem_2 = create(:poem)
		genre.poems.push(poem_1, poem_2)
		genre.save
		expect(genre.poems).to contain_exactly(poem_1, poem_2)
		expect(genre.poems_count).to eq(2)
	end

	it 'has many authors and knows its authors count' do
		save_models genre, user_a, user_b
		poem_1 = create(:poem, author: user_a)
		poem_2 = create(:poem, author: user_b)
		poem_3 = create(:poem, author: user_b)
		genre.poems.push(poem_1, poem_2, poem_3)
		genre.save
		expect(genre.authors).to contain_exactly(user_a, user_b)
		expect(genre.authors_count).to eq(2)
	end

end
