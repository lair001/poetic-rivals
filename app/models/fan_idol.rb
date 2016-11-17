class FanIdol < ApplicationRecord
	belongs_to :fan, class_name: :user
	belongs_to :idol, class_name: :user

	validates :fan, :idol, presence: true
end
