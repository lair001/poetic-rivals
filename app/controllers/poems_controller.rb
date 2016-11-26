class PoemsController < ApplicationController

	def index
		@poems = policy_scope(Poem.all)
	end

end
