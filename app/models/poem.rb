class Poem < ApplicationRecord
	include Forbiddable::InstanceMethods

	belongs_to :author, class_name: :user
	has_many :poem_genres
	has_many :genres, -> { distinct }, through: :poem_genres
	has_many :commentaries
	has_many :commentators, -> { distinct }, through: :commentaries
end
