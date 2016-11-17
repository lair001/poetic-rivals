class Genre < ApplicationRecord

	has_many :poem_genres
	has_many :poems, -> { distinct } , through: :poem_genres

	validates :name, length: { in: 2..30 }
end
