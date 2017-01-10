class UserSerializer < ApplicationSerializer

	attributes :id, :username, :role, :created_at_date, :created_at_time, :score, :rounded_score_per_poem

	def rounded_score_per_poem
		view_context.render_score_per_poem_for(object)
	end

end