def expect_redirect
  expect(response.status).to eq(302)
  follow_redirect!
  expect(response.status).to eq(200)
end

def expect_path(symbol)
	expect(path).to eq(self.send("#{symbol}_path"))
	expect(response.body).to include(self.send("#{symbol}_page_title")) if self.respond_to?("#{symbol}_page_title")
	expect(response.body).to include(self.send("#{symbol}_page_tagline")) if self.respond_to?("#{symbol}_page_tagline")
end

def expect_redirect_to_previous_path_or_root
	expected_path = previous_path_or_root
	expect_redirect
	expect(path).to eq(expected_path)
end

def expect_unauthorized_action
	expect_redirect_to_previous_path_or_root
	expect(response.body).to include(unauthorized_action_message)
end

def expect_unauthorized_access
	expect_redirect
	expect_path(:root)
	expect(response.body).to include(unauthorized_access_message)
end