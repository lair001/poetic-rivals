class Genre < ApplicationRecord

	has_many :poem_genres
	has_many :poems, -> { distinct } , through: :poem_genres

	validates :name, length: { in: 2..30 }

	def name=(name)
		write_attribute(:name, self.class.format_genre_name(name))
	end

	def self.format_genre_name(name)
		name.strip.gsub(/[\t\f\v\n\r\u00A0…\u2003]/, " ").gsub(/( ){2,}/, " ").gsub(/\s*\/\s*/, "/").split("/").collect{ |section| section.capitalize }.join("/")
	end

end