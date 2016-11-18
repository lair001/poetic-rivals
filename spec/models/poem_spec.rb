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

end
