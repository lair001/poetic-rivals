class PoemSerializer < ApplicationSerializer

	attributes :id, :title, :genres_list, :created_at_date, :created_at_time, :updated_at_date, :updated_at_time

end