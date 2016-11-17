class RivalVictim < ApplicationRecord

	belongs_to :rival, class_name: :User
	belongs_to :victim, class_name: :User

	validates :rival, :victim, presence: true

	validate do
		cannot_have_a_relationship_with_yourself
		a_couple_can_only_have_one_relationship_with_each_other if !self.errors.any?
	end

end
