class RivalVictim < ApplicationRecord

	belongs_to :rival, class_name: :User
	belongs_to :victim, class_name: :User

	validates :rival, :victim, presence: true

	validate do
		relationship :rival_id, :victim_id
	end

end
