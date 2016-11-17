class RivalVictim < ApplicationRecord

	belongs_to :rival, class_name: :user
	belongs_to :victim, class_name: :user

	validates :rival, :victim, presence: true
end
