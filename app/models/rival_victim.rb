class RivalVictim < ApplicationRecord

	belongs_to :rival, class_name: :User
	belongs_to :victim, class_name: :User

	validates :rival, :victim, presence: true

	validate do
		cannot_have_a_relationship_with_yourself
		a_couple_can_only_have_one_relationship_with_each_other if !self.errors.any?
	end

	after_create :update_victim_score_after_create
	after_destroy :update_victim_score_after_destroy

	def victim_score
		@victim_score ||= self.victim.score
	end

private

	def update_victim_score_after_create
		self.victim.update(score: self.victim_score - 100)
	end

	def update_victim_score_after_destroy
		self.victim.update(score: self.victim_score + 100)
	end

end
