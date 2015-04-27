class ProblemsController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, except: [:index, :show]

  def index
    @problems = Problem.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def new
    @problem = Problem.new
    authorize @problem
  end

  def create
    @problem = current_user.problems.create(secure_params)
    authorize @problem

    if @problem
      flash[:notice] = "New problem #{@problem.name} created successfully"
      redirect_to problems_path
    else
      flash[:warning] = "Problem couldn't be created"
      redirect_to new_problem_path
    end
  end

  def edit
    @problem = Problem.find(params[:id])
    authorize @problem
  end

  def update
    @problem = Problem.find(params[:id])
    authorize @problem
    if @problem.update_attributes(secure_params)
      redirect_to problems_path, :notice => "Problem \"#{@problem.name}\" was successfully updated!"
    else
      redirect_to problems_path, :alert => "Unable to update problem \"#{@problem.name}\" account for #{@user.name}."
    end
  end

  def destroy
    problem = Problem.find(params[:id])
    authorize problem
    problem.destroy
    redirect_to problems_path, :notice => "Problem successfully deleted."
  end

  private
  def secure_params
    params.require(:problem).permit(:name, :description, :language, :difficulty)
  end

end

