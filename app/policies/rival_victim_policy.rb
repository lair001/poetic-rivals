class RivalVictimPolicy < ApplicationPolicy

	def create?
		true
	end

	def destroy?
		@user == @record.rival || @user.administrator? || @user.superuser?
	end

end