class FanIdolPolicy < ApplicationPolicy

	def create?
		true
	end

	def destroy?
		@user == @record.fan || @user.administrator? || @user.superuser?
	end

end