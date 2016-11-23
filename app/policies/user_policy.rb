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
		@user.id != @record.id && !FanIdol.where("fan_id = ? AND idol_id = ?", @user.id, @record.id).exists? && !RivalVictim.where("rival_id = ? AND victim_id = ?", @user.id, @record.id).exists?
	end

end