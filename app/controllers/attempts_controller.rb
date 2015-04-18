class AttemptsController < ApplicationController
    before_filter :authenticate_user!
	def index
        @problem = Problem.find(params[:problem_id])
	    @attempts = Attempt.order(grade: :desc).where("problem_id = ?", @problem.id)
	end

    def show
        @attempt = Attempt.find(params[:id])
    end

    def new
    	@problem = Problem.find(params[:problem_id])
    	@attempt = Attempt.new
    end

    def create
        a = Attempt.new(create_params)

        a.user_id = current_user.id
        a.grade = -1

    	@problem = Problem.find(params[:problem_id])
    	a.problem_id = @problem.id
        
        if a.save
            flash[:notice] = "Attempt submitted successfully!"
            redirect_to problem_attempts_path(@problem.id)
        else
            flash[:warning] = "Attempt couldn't be submitted"
            redirect_to new_problem_attempt_path(@problem.id)
        end
    end

    def edit
        # @problem = Problem.find(params[:problem_id])
        @attempt = Attempt.find(params[:id])
    end

    def update

    end

private
    def create_params
        params.require(:attempt).permit(:submission)
    end

    def update_params
        params.require(:attempt).permit(:grade)
    end
            
end
