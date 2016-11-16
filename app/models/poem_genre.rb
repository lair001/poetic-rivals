class PoemGenre < ApplicationRecord
	belongs_to :poem
	belongs_to :genre

	validates :poem, :presence
	validates :genre, :presence
end
