class Admin::ApplicationController < ApplicationController

	before_action do 
		authorize :access, :admin?
	end

end