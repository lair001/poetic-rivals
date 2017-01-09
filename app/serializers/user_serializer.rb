class UserSerializer < ApplicationSerializer

	attributes :id, :username, :role, :created_at_date, :created_at_time, :score, :rounded_score_per_poem

	def created_at_date
		render_date(object.created_at)
	end

	def created_at_time
		render_time(object.created_at)
	end

	def rounded_score_per_poem
		render_score_per_poem_for(object).to_f
	end

end