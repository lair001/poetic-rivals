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
		expect(poem1.genres).to include(genre1, genre2)
  end

end
