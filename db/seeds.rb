# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include FactoryGirl::Syntax::Methods
require_all 'spec/spec_helper/config/faker'

genres = []
POETRY_GENRES.each do |poetry_genre|
	genres << create(:genre, name: poetry_genre)
end

users = []

users << create(:user, :random, :superuser, username: 'lair001', email: 'lair001@gmail.com')
users << create(:user, :random, :administrator, username: 'lair002', email: 'lair002@gmail.com')
users << create(:user, :random, :moderator, username: 'lair003', email: 'lair003@gmail.com')

2.times do
	users << create(:user, :random, :banned)
end

45.times do
	users << create(:user, :random)
end

poems = []
500.times do
	poems << create(:poem, author: users[rand(0..users.length-1)])
end

1500.times do
	begin
		create(:poem_genre, poem: poems[rand(0..poems.length-1)], genre: genres[rand(0..genres.length-1)])
	rescue ActiveRecord::RecordInvalid
	end
end

5000.times do
	begin
		create(:poem_voter, :up, poem: poems[rand(0..poems.length-1)], voter: users[rand(0..users.length-1)])
	rescue ActiveRecord::RecordInvalid
	end
end

5000.times do
	begin
		create(:poem_voter, :down, poem: poems[rand(0..poems.length-1)], voter: users[rand(0..users.length-1)])
	rescue ActiveRecord::RecordInvalid
	end
end

5000.times do
	create(:commentary, poem: poems[rand(0..poems.length-1)], commentator: users[rand(0..users.length-1)])
end

1000.times do
	begin
		create(:fan_idol, fan: users[rand(0..users.length-1)], idol: users[rand(0..users.length-1)])
	rescue ActiveRecord::RecordInvalid
	end
end

1000.times do
	begin
		create(:rival_victim, rival: users[rand(0..users.length-1)], victim: users[rand(0..users.length-1)])
	rescue ActiveRecord::RecordInvalid
	end
end