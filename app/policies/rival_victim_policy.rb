class RivalVictimPolicy < ApplicationPolicy

	def create?
		!@user.banned?
	end

	def destroy?
		!@user.banned? || @user == @record.rival || @user.admin? || @user.superuser?
	end

end