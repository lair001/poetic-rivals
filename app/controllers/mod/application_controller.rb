class Mod::ApplicationController < ApplicationController

	before_action do
		authorize :access, :mod?
	end

end