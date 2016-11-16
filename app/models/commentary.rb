class Commentary < ApplicationRecord
	belongs_to :commentator, class_name: :user
	belongs_to :poem

	validates :commentator, :presence
	validates :poem, :presence
end
