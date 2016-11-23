class AccessPolicy < Struct.new(:user, :access)

	def admin?
		user.administrator? || user.superuser? ? true : false
	end

	def mod?
		user.moderator? || user.superuser? ? true : false
	end

	def app?
		user && !user.banned? ? true : false
	end

end