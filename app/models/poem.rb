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

	def genre_attributes=(genre_params)
		self.genres << Genre.find_or_create_by(name: genre_params[:name].downcase)
	end

end
