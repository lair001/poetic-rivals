class RivalPolicy < ApplicationPolicy

	def create?
		current_user.normal?
	end

	def destroy?
		current_user == @record.rival || current_user.admin? || current_user.superuser?
	end

end