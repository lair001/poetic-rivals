class Genre < ApplicationRecord

	has_many :poem_genres
	has_many :poems, -> { distinct } , through: :poem_genres
	has_many :authors, -> { distinct } , through: :poems

	validates :name, { uniqueness: true, length: { in: 2..30 } }

	validate do
		absence_of_forbidden_characters_in :name
	end

	def banned=(boolean)
		self.send("banned?=", boolean)
	end

	def status
		banned? ? "Banned" : "Mostly Harmless"
	end

	def poems_ordered_by_descending_updated_at
		self.poems.order(updated_at: :desc)
	end

	def authors_ordered_by_descending_score
		self.authors.order(score: :desc)
	end

	def poems_count
		self.poems.count
	end

	def authors_count
		self.authors.count
	end


	def name=(name)
		write_attribute(:name, self.class.format_name(name))
	end

	def self.format_name(name)
		name.strip.gsub(/[\t\f\v\n\r\u00A0…\u2003]/, " ").gsub(/( ){2,}/, " ").gsub(/\s*\/\s*/, "/").split("/").collect{ |section| section.capitalize }.join("/")
	end

	def self.ordered_by_ascending_name
		@@ordered_by_ascending_name ||= self.all.order(name: :asc)
	end

end