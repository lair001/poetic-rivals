class User < ApplicationRecord

 	has_many :poems, foreign_key: :author_id
 	has_many :genres, -> { distinct }, through: :poems
 	has_many :poem_voters, -> { distinct }, through: :poems
 	has_many :commentaries, foreign_key: :commentator_id
 	has_many :commentators, -> { distinct }, through: :poems

 	has_many :rivalry_declarations, class_name: :RivalVictim, foreign_key: :rival_id
 	has_many :victimizations, class_name: :RivalVictim, foreign_key: :victim_id

 	has_many :victims, -> { distinct }, through: :rivalry_declarations
	has_many :rivals, -> { distinct }, through: :victimizations

 	has_many :fandom_declarations, class_name: :FanIdol, foreign_key: :fan_id
 	has_many :idolizations, class_name: :FanIdol, foreign_key: :idol_id

 	has_many :idols, -> { distinct }, through: :fandom_declarations
	has_many :fans, -> { distinct }, through: :idolizations

	validates :username, { uniqueness: true, length: { in: 2..30 }, format: { without: Devise.email_regexp, message: "cannot be an email address" } }

	validate do
		absence_of_forbidden_characters_in :username
		absence_of_forbidden_characters_in :password
		absence_of_forbidden_characters_in :email
		only_spaces_as_whitespace_in :username
		absence_of_whitespace_in :email
		absence_of_whitespace_in :password
	end

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, authentication_keys: [:username]
	devise :omniauthable, :omniauth_providers => [:amazon, :facebook, :github, :google_oauth2]
	devise :registerable, :recoverable, :rememberable, :trackable, :validatable

	enum role: [:banned, :poet, :administrator, :moderator, :superuser]

	def relationship?(model, relationships_symbol, relationship_query_lambda)
		@relationships = {} if !@relationships
		if @relationships.has_key?(relationships_symbol)
			@relationships[relationships_symbol].each { |relationship| return relationship[1] if relationship[0] == model.id }
		else
			@relationships[relationships_symbol] = []
		end
		@relationships[relationships_symbol] << [model.id, relationship_query_lambda.()]
		@relationships[relationships_symbol].last[1]
	end

	def voting_on?(poem)
		upvoting?(poem) || downvoting?(poem)
	end

	def upvoting?(poem)
		self.relationship?(poem, :upvotings, -> { PoemVoter.where("voter_id = ? AND poem_id = ? AND value = 1", self.id, poem.id).exists? })
	end

	def downvoting?(poem)
		self.relationship?(poem, :downvotings, -> { PoemVoter.where("voter_id = ? AND poem_id = ? AND value = -1", self.id, poem.id).exists? })
	end

	def can_view?(poem)
		!banned? && (!poem.private? || poem.author == self || self.moderator? || self.superuser?)
	end

	def idolizing?(user)
		self.relationship?(user, :idolizings, -> { FanIdol.where("fan_id = ? AND idol_id = ?", self.id, user.id).exists? } )
		# @idolizings = [] if !@idolizings
		# @idolizings.each { |idolizing| return idolizing[1] if idolizing[0] == user.id }
		# @idolizings << [user.id, FanIdol.where("fan_id = ? AND idol_id = ?", self.id, user.id).exists?]
		# @idolizings[0][1]
	end

	def victimizing?(user)
		self.relationship?(user, :victimizings, -> { RivalVictim.where("rival_id = ? AND victim_id = ?", self.id, user.id).exists? } )
		# @victimizings = [] if !@victimizings
		# @victimizings.each { |victimizing| return victimizing[1] if victimizing[0] == user.id }
		# @victimizings << [user.id, RivalVictim.where("rival_id = ? AND victim_id = ?", self.id, user.id).exists?]
		# @victimizings[0][1]
	end

	def poems_count
		@poems_count ||= self.poems.count
	end

	def upvotes_count
		@upvotes_count ||= self.poem_voters.where(value: 1).count
	end

	def downvotes_count
		@downvotes_count ||= self.poem_voters.where(value: -1).count
	end

	def fans_count
		@fans_count ||= self.fans.count
	end

	def idols_count
		@idols_count ||= self.idols.count
	end

	def rivals_count
		@rivals_count ||= self.rivals.count
	end

	def victims_count
		@victims_count ||= self.victims.count
	end

	def poem_score
		@poem_score ||= self.poem_voters.sum(:value)
	end

	def relationship_score
		@relationship_score ||= 100 * (fans_count - rivals_count)
	end

	def refresh_score
		# @score ||= 100 * (self.fans.count - self.rivals.count) + self.poem_voters.where(value: 1).count - self.poem_voters.where(value: -1).count
		# fancount = self.class.all.select("COUNT(fan_idols.fan_id) AS fancount").joins(:victimizations, :idolizations, poems: :poem_voters).group("users.id").having("users.id = ?", self.id).first["fancount"]
		# rivalcount = self.class.all.select("COUNT(rival_victims.rival_id) AS rivalcount").joins(:victimizations, :idolizations, poems: :poem_voters).group("users.id").having("users.id = ?", self.id).first["rivalcount"]
		# poemscore = self.class.all.select("SUM(poem_voters.value) AS poemscore").joins(:victimizations, :idolizations, poems: :poem_voters).group("users.id").having("users.id = ?", self.id).first["poemscore"]
		# @score ||= self.class.all.select("(100 * ( COUNT(fan_idols.fan_id) - COUNT(rival_victims.rival_id) ) + SUM(poem_voters.value)) AS score").joins(:rivals, :fans, :poem_voters).group("users.id").having("users.id = ?", self.id).first["score"]
		self.update(score: relationship_score + poem_score)
	end

	def score_per_poem
		@score_per_poem ||= score.to_f / [1, self.poems_count].max # avoid division by zero
	end

	def self.user_scores
		@@user_scores ||= self.all.select("id").collect{ |user| [user.id, user.score] }
	end

	def self.ordered_by_ascending_username
		@@ordered_by_ascending_username ||= self.order(username: :asc)
	end

	def self.ordered_by_descending_score
		@@ordered_by_descending_score ||= self.order(score: :desc)
	end

	def self.with_highest_score
		@@with_highest_score ||= ordered_by_descending_score.first
	end

	def self.with_lowest_score
		@@with_lowest_score ||= ordered_by_descending_score.last
	end

	def self.with_most_fans
		@@with_most_fans ||= self.left_outer_joins(:idolizations).group(:id).order("COUNT(fan_idols.id) DESC").first
	end

	def self.with_most_idols
		@@with_most_idols ||= self.left_outer_joins(:fandom_declarations).group(:id).order("COUNT(fan_idols.id) DESC").first
	end

	def self.with_most_rivals
		@@with_most_rivals ||= self.left_outer_joins(:victimizations).group(:id).order("COUNT(rival_victims.id) DESC").first
	end

	def self.with_most_victims
		@@with_most_victims ||= self.left_outer_joins(:rivalry_declarations).group(:id).order("COUNT(rival_victims.id) DESC").first
	end

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

end
