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

	def relationship?
		@user.id != @record.id && !@user.idolizing?(@record) && !@user.victimizing?(@record)
	end

end