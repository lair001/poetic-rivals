require 'rails_helper'

RSpec.describe Poem, type: :model do
  it 'knows its title' do
  	title = Faker::Lorem.sentence.chomp(".").titleize
  	poem = build_stubbed(:poem, title: title)
	expect(poem.title).to eq(title)
  end
end
