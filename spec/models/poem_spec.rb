require 'rails_helper'

RSpec.describe Poem, type: :model do
	it 'knows its title' do
  		title = fake_title
		expect(build_stubbed(:poem, title: title).title).to eq(title)
	end

	it 'knows its body' do
  		body = fake_two_paragraphs
		expect(build_stubbed(:poem, body: body).body).to eq(body)
	end

	it 'is private by default' do
  		expect(build_stubbed(:poem).private?).to eq(false)
	end

	it 'can be made private' do
  		expect(build_stubbed(:poem, :private).private?).to eq(true)
	end

	it 'knows its author' do
  		user1 = build_stubbed(:user)
  		expect(build(:poem, author: user1).author).to eq(user1)
	end

	it 'has many genres' do
  		poem1 = create(:poem)
		genre1 = create(:genre)
		genre2 = create(:genre)
		poem1.genres.push(genre1, genre2)
		poem1.save
		expect(poem1.genres).to contain_exactly(genre1, genre2)
	end

	it 'has many commentataries' do
		poem1 = create(:poem)
		commentary1 = create(:commentary, poem: poem1)
		commentary2 = create(:commentary, poem: poem1)
		expect(poem1.commentaries).to contain_exactly(commentary1, commentary2)
	end

	it 'has many commentators' do
		poem1 = create(:poem)
		user1 = create(:user)
		user2 = create(:user)
		create(:commentary, poem: poem1, commentator: user1)
		create(:commentary, poem: poem1, commentator: user1)
		create(:commentary, poem: poem1, commentator: user2)
		expect(poem1.commentators).to contain_exactly(user1, user2)
	end

	it 'has many poem_voters' do
		poem1 = create(:poem)
		poem_voter1 = create(:poem_voter, :up, poem: poem1)
		poem_voter2 = create(:poem_voter, :down, poem: poem1)
		expect(poem1.poem_voters).to contain_exactly(poem_voter1, poem_voter2)
	end

	it 'knows its upvotes count and downvotes_count' do
		save_models poem
		upvotes_count = rand(1..15)
		downvotes_count = rand(1..15)
		create_poem_voters_for(poem, upvotes_count, downvotes_count)
		expect(poem.upvotes_count).to eq(upvotes_count)
		expect(poem.downvotes_count).to eq(downvotes_count)
	end

	it 'accepts nested params for genre' do
		save_models user
		genre_name = fake_genre
		params = attributes_for :poem
		params[:author_id] = user.id
		params[:genre_attributes] = {name: genre_name}
		poem_1 = Poem.create(params)
		expect(poem_1.genres.where(name: genre_name).count).to eq(1)
	end

	it 'does not duplicate a genre that already exists' do
		save_models user
		genre_name = fake_genre
		create(:genre, name: genre_name)
		params = attributes_for :poem
		params[:author_id] = user.id
		params[:genre_attributes] = {name: genre_name}
		poem_1 = Poem.create(params)
		expect(poem_1.genres.where(name: genre_name).count).to eq(1)
		expect(Genre.where(name: genre_name).count).to eq(1)
	end

	it 'accepts attributes for many genres' do
		save_models poem, genre_a, genre_b, genre_c, genre_d, genre_e
		params = {
			genres_attributes: {
				0 => { name: genre_a.name },
				1 => { name: genre_b.name },
				2 => { name: genre_c.name }
			},
			genre_ids: [genre_d.id, genre_e.id]
		}
		poem.update(params)
		expect(poem.genres).to contain_exactly(genre_a, genre_b, genre_c, genre_d, genre_e)
		params = {
			genres_attributes: {
				0 => { name: genre_e.name }
			},
			genre_ids: [genre_a.id]
		}
		poem.update(params)
		expect(poem.genres).to contain_exactly(genre_a, genre_e)
	end

end
