class CommentaryPolicy < ApplicationPolicy

	def edit?
		update?
	end

	def update?
		@user.moderator? || @user.superuser? || @user = @record.commentator
	end

	def destroy?
		update?
	end

end