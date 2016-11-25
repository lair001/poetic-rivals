class GenrePolicy < ApplicationPolicy

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