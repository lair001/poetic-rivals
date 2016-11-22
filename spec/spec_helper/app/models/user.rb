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

def build_fans_for(user, number_of_fans)
	(1..number_of_fans).to_a.collect do
		user.fans.build(attributes_for :user)
	end
end

def build_idols_for(user, number_of_idols)
	(1..number_of_idols).to_a.collect do
		user.idols.build(attributes_for :user)
	end
end

def build_rivals_for(user, number_of_rivals)
	(1..number_of_rivals).to_a.collect do
		user.rivals.build(attributes_for :user)
	end
end

def build_victims_for(user, number_of_victims)
	(1..number_of_victims).to_a.collect do
		user.victims.build(attributes_for :user)
	end
end
