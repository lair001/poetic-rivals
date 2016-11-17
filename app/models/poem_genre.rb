class PoemGenre < ApplicationRecord
	belongs_to :poem
	belongs_to :genre

	validates :poem, :genre, presence: true
end
