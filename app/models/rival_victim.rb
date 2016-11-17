class RivalVictim < ApplicationRecord

	belongs_to :rival, class_name: :User
	belongs_to :victim, class_name: :User

	validates :rival, :victim, presence: true

	validate do
		cannot_have_a_relationship_with_yourself
		absence_of_identical_relationship_among_relatable_models if !self.errors.any?
	end

end
