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
    if @problem = current_user.problems.create(create_params)
      flash[:notice] = "New problem #{@problem.name} created successfully"
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

