class GenrePolicy < ApplicationPolicy

	def show?
		!@record.banned? || @user.administrator? || @user.superuser?
	end

	class Scope < Scope

		def resolve
			if user.administrator? || user.superuser?
				scope
			else
				scope.where("banned = false")
			end
		end

	end

end