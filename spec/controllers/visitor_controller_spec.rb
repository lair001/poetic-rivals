require 'rails_helper'

RSpec.describe VisitorController, type: :controller do

	describe "#index" do
		it 'renders the root page' do
			get :index
			expect(response).to render_template(:index)
		end
	end

	describe "#aqm" do
		it 'renders the aqm page' do
			get :aqm
			expect(response).to render_template(:aqm)
		end
	end

end
