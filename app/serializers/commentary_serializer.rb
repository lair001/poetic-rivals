class CommentarySerializer < ApplicationSerializer

	attributes :id, :created_at_date, :created_at_time, :updated_at_date, :updated_at_time, :rendered_comment, :can_edit
	belongs_to :commentator, serializer: CommentaryCommentatorSerializer

	def rendered_comment
		view_context.render_comment_for(object)
	end


end