class CommentaryPolicy < ApplicationPolicy

	def show?
		PoemPolicy.new(@user, @record.poem).show?
	end

	def new?
		create?
	end

	def create?
		PoemPolicy.new(@user, @record.poem).show? && @user == @record.commentator
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