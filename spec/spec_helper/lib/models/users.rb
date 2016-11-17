def expect_user_role_to_be(user, reference_role)
	reference_role_string = reference_role.to_s
	expect(user.role).to eq(reference_role_string)
	User.roles.keys.each do |role|
		if role == reference_role_string
			expect(user.send("#{role}?")).to eq(true)
		else
			expect(user.send("#{role}?")).to eq(false)
		end
	end
end
