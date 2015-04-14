class AttemptsController < ApplicationController

	def index
		@attempts = Attempt.all
	end
end
