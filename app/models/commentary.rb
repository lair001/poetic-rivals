class Commentary < ApplicationRecord
	belongs_to :commentator, class_name: :User
	belongs_to :poem

	validates :commentator, :poem, presence: true
	validates :comment, length: { in: 1..65536 }

	validate do
		absence_of_forbidden_characters_in :comment
	end

	def comment=(comment)
		write_attribute(:comment, self.class.format_comment(comment))
	end

	def commentator_username
		self.commentator.username
	end

	def self.format_comment(comment)
		trim_whitespace_in(comment)
	end

end
