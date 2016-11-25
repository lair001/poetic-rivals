class ApplicationRecord
	module Whitespaceable
		module ClassMethods

			def trim_whitespace_in(string)
				string.strip.gsub(/(?<foo>(\s|\u00A0|\u2003))( |\u00A0)/, '\k<foo>'  ).gsub(/( |\u00A0)(?<foo>(\s|\u00A0|\u2003))/, '\k<foo>')
			end

			def convert_whitespace_that_is_not_spaces_to_spaces_in(string)
				string.gsub(/[\t\f\v\n\r\u00A0…\u2003]/, " ")
			end

		end

	end
end