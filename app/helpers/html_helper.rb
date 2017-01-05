module HtmlHelper

	def convert_whitespace_to_html_in(string)
		string.gsub(/\t/, "&emsp;&emsp;").gsub(/\u2003/, "&emsp;").gsub(/\r\n/, "<br>").gsub(/[\f\n\r]/, "<br>").gsub(/\v/, "<br><br>")
	end

	def render_page_title(model = nil)
		if self.respond_to?("#{current_path_name}_page_title")
			title = model && self.method("#{current_path_name}_page_title").arity != 0 ? self.send("#{current_path_name}_page_title", model) : self.send("#{current_path_name}_page_title")
			"<h1 id='page_title'>#{title}</h1>"
		else
			""
		end
	end

	def render_page_tagline(model = nil)
		if self.respond_to?("#{current_path_name}_page_tagline")
			tagline = model && self.method("#{current_path_name}_page_tagline").arity != 0 ? self.send("#{current_path_name}_page_tagline", model) : self.send("#{current_path_name}_page_tagline")
			"<h2 id='page_tagline'><em>#{tagline}</em></h2>"
		else
			""
		end
	end

	def render_genres_for(model)
		raw(policy_scope(model.genres).collect{ |genre| link_to genre.name, genre_path(genre)}.join(", "))
	end

	def data_confirm_message
		"Are you sure?"
	end

end