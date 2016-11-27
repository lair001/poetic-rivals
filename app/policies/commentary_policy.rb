class CommentaryPolicy < ApplicationPolicy

	def show?
		authorize(@record.poem, :show?)
	end

	def new?
		create?
	end

	def create?
		authorize(@record.poem, :show?)
	end

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