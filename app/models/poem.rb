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

	def genre_attributes=(genre_params)
		self.genres << Genre.find_or_create_by(name: Genre.format_name(genre_params[:name]))
	end

	def title=(title)
		write_attribute(:title, self.class.format_title(title))
	end

	def body=(body)
		write_attribute(:body, self.class.format_body(body))
	end

	def self.format_title(title)
		trim_whitespace_in(convert_whitespace_that_is_not_spaces_to_spaces_in(title))
	end

	def self.format_body(body)
		trim_whitespace_in(body)
	end

end
