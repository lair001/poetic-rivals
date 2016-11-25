class PoemPolicy < ApplicationPolicy

	class Scope < Scope

		def resolve
			if user.moderator? || user.superuser?
				scope
			else
				scope.where("private = false OR author_id = ?", user.id)
			end
		end

	end

end