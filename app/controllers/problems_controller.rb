class ProblemsController < ApplicationController
	before_filter :authenticate_user!
	def index
    	@problems = Problem.all
  	end

  	def show
    	@problem = Problem.find(params[:id])
  	end

  	def new
  		@problem = Problem.new
  	end

  	def create
		p = Problem.new(create_params)
		p.user_id = current_user.id
		if p.save
			flash[:notice] = "New problem #{p.name} created successfully"
			redirect_to problems_path
		else
			flash[:warning] = "Problem couldn't be created"
			redirect_to new_problem_path
		end
	end

private
	def create_params
		params.require(:problem).permit(:name, :description, :difficulty)
	end

end

