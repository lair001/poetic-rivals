class UserPolicy < ApplicationPolicy

	def ban?
		if @user.moderator? && (@record.normal? || @record.banned?)
			true
		elsif @user.superuser? && !@record.superuser?
			true
		else
			false
		end
	end

end