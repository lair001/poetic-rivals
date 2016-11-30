class PoemPolicy < ApplicationPolicy

	def create?
		@user = @record.author
	end

	def edit?
		@user.moderator? || @user.superuser? || @user == @record.author
	end

	def update?
		edit?
	end

	def vote?
		@user != @record.author && !@user.voting_on?(@record)
	end

	def show?
		!@record.private? || @user == @record.author || @user.administrator? || @user.superuser?
	end

	class Scope < Scope

		def resolve
			if user.moderator? || user.superuser?
				scope
			else
				scope.where(private?: false).or(scope.where(author_id: user.id))
			end
		end

	end

end