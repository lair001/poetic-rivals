class PoemsController < ApplicationController

	def index
		@poems = policy_scope(Poem.all)
	end

	def show
		@poem = Poem.find(params[:id])
	end

end
