class User < ApplicationRecord

 	include UserForbiddable::InstanceMethods

 	has_many :poems, foreign_key: :author_id
 	has_many :genres, -> { distinct }, through: :poems
 	has_many :commentaries, foreign_key: :commentator_id
 	has_many :commentators, -> { distinct }, through: :poems

 	has_many :rivalry_declarations, class_name: :rival_victim, foreign_key: :rival_id
 	has_many :victimizations, class_name: :rival_victim, foreign_key: :victim_id

 	has_many :victims, -> { distinct }, through: :rivalry_declarations
	has_many :rivals, -> { distinct }, through: :victimizations

 	has_many :fandom_declarations, class_name: :fan_idol, foreign_key: :fan_id
 	has_many :idolizations, class_name: :fan_idol, foreign_key: :idol_id

 	has_many :idols, -> { distinct }, through: :fandom_declarations
	has_many :fans, -> { distinct }, through: :idolizations

	validates :username, { uniqueness: true, length: { in: 2..20 }, format: { without: Devise.email_regexp, message: "cannot be an email address" } }

	validate do
		absence_of_forbidden_characters_in :username
		absence_of_forbidden_characters_in :password
		only_spaces_as_whitespace_in :username
		absence_of_whitespace_in :email
		absence_of_whitespace_in :password
	end

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, authentication_keys: [:username]
	devise :omniauthable, :omniauth_providers => [:amazon, :facebook, :github, :google_oauth2]
	devise :registerable, :recoverable, :rememberable, :trackable, :validatable

	enum role: [:banned, :normal, :administrator, :moderator, :superuser]

	def self.from_omniauth(auth)
		# where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		# 	user.username = auth.info.email
		# 	user.email = auth.info.email
		# 	user.password = Devise.friendly_token[0,20]
		# end
		# where(email: auth.info.email).first_or_create do |user|
		# 	user.username = auth.info.email
		# 	user.email = auth.info.email
		# 	user.password = Devise.friendly_token[0,20]
		# end
		where(email: auth.info.email).first
	end

	def title
		@title ||= self.grant_title
	end

	def grant_title
		if self.banned?
			"Banned"
		elsif self.superuser?
			"Superuser"
		elsif self.administrator?
			"Administrator"
		elsif self.moderator?
			"Moderator"
		else
			"Poet"
		end
	end

end
