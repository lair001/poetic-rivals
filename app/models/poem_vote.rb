class PoemVote < ApplicationRecord

	belongs_to :poem

	validates :poem, { presence: true, uniqueness: true }
	validates :value, inclusion: { in: [-1, 1] }

end
