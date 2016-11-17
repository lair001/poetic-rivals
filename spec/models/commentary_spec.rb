require 'rails_helper'

RSpec.describe Commentary, type: :model do

	it 'knows its comment' do
		comment = fake_two_paragraphs
		expect(build_stubbed(:commentary, comment: comment).comment).to eq(comment)
	end

	it 'knows its commentator' do
		user = build_stubbed(:user)
		expect(build_stubbed(:commentary, commentator: user).commentator).to eq(user)
	end

	it 'knows its poem' do
		poem = build_stubbed(:poem)
		expect(build_stubbed(:commentary, poem: poem).poem).to eq(poem)
	end

	it 'validates for the presence of a comment' do
		expect(build(:commentary, comment: "").save).to eq(false)
	end

	it 'validates for the presence of a comment' do
		expect(build(:commentary, comment: "").save).to eq(false)
	end

	it 'validates for the presence of a poem' do
		expect(build(:commentary, poem: nil).save).to eq(false)
	end

	it 'validates for the presence of a commentator' do
		expect(build(:commentary, commentator: nil).save).to eq(false)
	end

end
