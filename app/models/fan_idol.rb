class FanIdol < ApplicationRecord

	belongs_to :fan, class_name: :User
	belongs_to :idol, class_name: :User

	validates :fan, :idol, presence: true

	validate do
		cannot_have_a_relationship_with_yourself
		a_couple_can_only_have_one_relationship_with_each_other if !self.errors.any?
	end

end
