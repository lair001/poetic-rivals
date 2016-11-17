class Commentary < ApplicationRecord
	belongs_to :commentator, class_name: :User
	belongs_to :poem

	validates :commentator, :poem, presence: true
	validates :comment, length: { in: 1..65536 }
end
