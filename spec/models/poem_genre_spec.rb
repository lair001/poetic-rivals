require 'rails_helper'

RSpec.describe PoemGenre, type: :model do  

	it 'knows about its poem' do
		poem = build(:poem)
		expect(build(:poem_genre, poem: poem).poem).to eq(poem)
	end

	it 'knows about its genre' do
		genre = build(:genre)
		expect(build(:poem_genre, genre: genre).genre).to eq(genre)
	end

end
