class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, authentication_keys: [:username]
	devise :omniauthable, :omniauth_providers => [:facebook]
	devise :registerable, :recoverable, :rememberable, :trackable, :validatable

	validates :username, presence: true

	def self.from_omniauth(auth)
		# where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		# 	user.username = auth.info.email
		# 	user.email = auth.info.email
		# 	user.password = Devise.friendly_token[0,20]
		# end
		where(email: auth.info.email).first_or_create do |user|
			user.username = auth.info.email
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
		end
	end

end
