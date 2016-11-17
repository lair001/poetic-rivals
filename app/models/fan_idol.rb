class FanIdol < ApplicationRecord
	belongs_to :fan, class_name: :User
	belongs_to :idol, class_name: :User

	validates :fan, :idol, presence: true

	validate do
		relationship :fan_id, :idol_id
	end

end
