class PoemVoter < ApplicationRecord

	belongs_to :poem
	belongs_to :voter, class_name: :User

	validates :poem, :voter, presence: true
	validates :value, inclusion: { in: [-1, 1] }

	validate do
		unique_vote
		cannot_vote_for_your_own_poem
	end

	def unique_vote
		errors.add(:base, "Cannot vote for the same poem more than once") if self.class.all.where(poem_id: self.poem_id, voter_id: self.voter_id).first
	end

	def cannot_vote_for_your_own_poem
		errors.add(:base, "Cannot vote for your own poem") if Poem.all.where(id: self.poem_id, author_id: self.voter_id).first
	end

end
