class FanIdol < ApplicationRecord

	belongs_to :fan, class_name: :User
	belongs_to :idol, class_name: :User

	validates :fan, :idol, presence: true

	validate do
		cannot_have_a_relationship_with_yourself
		a_couple_can_only_have_one_relationship_with_each_other if !self.errors.any?
	end

	after_create :update_idol_score_after_create
	after_destroy :update_idol_score_after_destroy

	def idol_score
		@idol_score ||= self.idol.score
	end

private

	def update_idol_score_after_create
		self.idol.update(score: self.idol_score + 100)
	end

	def update_idol_score_after_destroy
		self.idol.update(score: self.idol_score - 100)
	end

end
