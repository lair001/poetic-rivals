class FanIdol < ApplicationRecord

	belongs_to :fan, class_name: :User
	belongs_to :idol, class_name: :User

	validates :fan, :idol, presence: true

	validate do
		cannot_have_a_relationship_with_yourself
		absence_of_identical_relationship_among_relatable_models if !self.errors.any?
	end

end
