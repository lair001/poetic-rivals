class Commentary < ApplicationRecord
	belongs_to :commentator, class_name: :user
	belongs_to :poem

	validates :commentator, :poem, presence: true
end
