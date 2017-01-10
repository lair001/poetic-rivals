class ApplicationSerializer < ActiveModel::Serializer

	def created_at_date
		view_context.render_date(object.created_at)
	end

	def created_at_time
		view_context.render_time(object.created_at)
	end

	def updated_at_date
		view_context.render_date(object.updated_at)
	end

	def updated_at_time
		view_context.render_time(object.updated_at)
	end

	def genres_list
		view_context.render_genres_for(object)
	end

	def rendered_role
		view_context.render_role_for(object)
	end

	def can_edit
		view_context.policy(object).edit?
	end

protected



end