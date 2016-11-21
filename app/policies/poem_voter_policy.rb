class PoemVoterPolicy < ApplicationPolicy

	def create?
		true
	end

	def destroy?
		@user == @record.voter || @user.administrator? || @user.superuser?
	end

end