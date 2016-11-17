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

def generate_fans_for(user, number_of_fans)
	number_of_fans.times do
		user.fans.build(attributes_for :user)
	end
end

def generate_rivals_for(user, number_of_rivals)
	number_of_rivals.times do
		user.rivals.build(attributes_for :user)
	end
end
