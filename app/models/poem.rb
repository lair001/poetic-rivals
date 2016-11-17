class Poem < ApplicationRecord
	include Forbiddable::InstanceMethods

	belongs_to :author, class_name: :User
	has_many :poem_genres
	has_many :genres, -> { distinct }, through: :poem_genres
	has_many :commentaries
	has_many :commentators, -> { distinct }, through: :commentaries

	validates :author, presence: true
	validates :title, length: { in: 2..255 }
	validates :body, length: { in: 20..65536 }
end
