require 'rails_helper'

RSpec.describe "Visitor", type: :request do
	describe "GET #{root_path}" do
		it "renders the root page" do
			get root_path
			expect(response.status).to eq(200)
			expect_path(:root)
		end
	end
	describe "GET #{aqm_path}" do
		it "renders the aqm page" do
			get aqm_path
			expect(response.status).to eq(200)
			expect_path(:aqm)
		end
	end
end
