module HtmlHelper

	def convert_whitespace_to_html_in(string)
		string.gsub(/\t/, "&emsp;&emsp;").gsub(/\u2003/, "&emsp;").gsub(/\r\n/, "<br>").gsub(/[\f\n\r]/, "<br>").gsub(/\v/, "<br><br>")
	end

end