class Poem < ApplicationRecord

	belongs_to :author, class_name: :User
	has_many :poem_genres
	has_many :genres, -> { distinct }, through: :poem_genres
	has_many :commentaries
	has_many :commentators, -> { distinct }, through: :commentaries
	has_many :poem_voters

	validates :author, presence: true
	validates :title, length: { in: 2..255 }
	validates :body, length: { in: 20..65536 }

	validate do
		absence_of_forbidden_characters_in :title
		absence_of_forbidden_characters_in :body
	end

	def private=(boolean)
		self.send("private?=", boolean)
	end

	def upvotes_count
		self.poem_voters.where(value: 1).count
	end

	def downvotes_count
		self.poem_voters.where(value: -1).count
	end

	def genres_attributes=(genre_params_hash_array)
		genre_params_hash_array.values.each do |genre_params|
			self.genre_attributes = genre_params
		end
	end

	def genre_attributes=(genre_params)
		self.genres << Genre.find_or_create_by(genre_params)
	end

	def title=(title)
		write_attribute(:title, self.class.format_title(title))
	end

	def body=(body)
		write_attribute(:body, self.class.format_body(body))
	end

	def author_username
		self.author.username
	end

	def self.format_title(title)
		trim_whitespace_in(convert_whitespace_that_is_not_spaces_to_spaces_in(title))
	end

	def self.format_body(body)
		trim_whitespace_in(body)
	end

end
