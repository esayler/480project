class ProblemsController < ApplicationController
	def index
    	@problems = Problem.all
  	end

  	def show
    	@problem = Problem.find(params[:id])
  	end

  	def new
  	end

  	def create
		p = Problem.new()
		if p.save
			flash[:notice] = "New problem #{p.name} created successfully"
			redirect_to problems_path
		else
			flash[:warning] = "Problem couldn't be created"
			redirect_to new_problem_path
		end
	end
end
