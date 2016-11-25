class PoemVoter < ApplicationRecord

	belongs_to :poem
	belongs_to :voter, class_name: :User

	validates :poem, :voter, presence: true
	validates :value, inclusion: { in: [-1, 1] }

	validate do
		cannot_vote_for_your_own_poem
		unique_vote
	end

	after_create :update_poem_author_score_after_create
	after_destroy :update_poem_author_score_after_destroy

	def poem_author
		@poem_author ||= self.poem.author
	end

	def poem_author_score
		@poem_author_score ||= self.poem_author.score
	end

private

	def update_poem_author_score_after_create
		self.poem_author.update(score: self.poem_author_score + self.value)
	end

	def update_poem_author_score_after_destroy
		self.poem_author.update(score: self.poem_author_score - self.value)
	end

	def unique_vote
		errors.add(:base, "Cannot vote for the same poem more than once") if self.class.all.where(poem_id: self.poem_id, voter_id: self.voter_id).first
	end

	def cannot_vote_for_your_own_poem
		errors.add(:base, "Cannot vote for your own poem") if Poem.all.where(id: self.poem_id, author_id: self.voter_id).first
	end

end
