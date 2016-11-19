def expect_path(symbol)
	expect(path).to eq(self.send("#{symbol}_path"))
	expect(response.body).to include(self.send("#{symbol}_page_title")) if self.respond_to?("#{symbol}_page_title")
	expect(response.body).to include(self.send("#{symbol}_page_tagline")) if self.respond_to?("#{symbol}_page_tagline")
end