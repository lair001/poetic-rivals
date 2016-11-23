def expect_redirect
  expect(response.status).to eq(302)
  follow_redirect!
  expect(response.status).to eq(200)
end

def expect_path(symbol, model = nil)
	expect(path).to eq(self.send("#{symbol}_path"))
	if self.respond_to?("#{symbol}_page_title")
		if self.method("#{symbol}_page_title").arity != 0
			expect(response.body).to include(self.send("#{symbol}_page_title", model))
		else
			expect(response.body).to include(self.send("#{symbol}_page_title"))
		end
	end
	if self.respond_to?("#{symbol}_page_tagline")
		if self.method("#{symbol}_page_tagline").arity != 0
			expect(response.body).to include(self.send("#{symbol}_page_tagline", model))
		else
			expect(response.body).to include(self.send("#{symbol}_page_tagline"))
		end
	end
end

def expect_redirect_to_previous_path_or_root
	expected_path = previous_path_or_root
	expect_redirect
	expect(path).to eq(expected_path)
end

def expect_unauthorized_action
	expect_unauthorized_access_or_action
end

def expect_unauthorized_access
	expect_unauthorized_access_or_action
end

def expect_unauthorized_access_or_action
	expect_redirect
	expect_path(:root)
	expect(response.body).to include(unauthorized_access_or_action_message)
end