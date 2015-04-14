class AttemptsController < ApplicationController
        before_filter :authenticate_user!
	def index
	    @attempts = Attempt.all
	end

        def show
            @attempt = Attempt.find(params[:id])
        end

        def new
        end

        def create
            a = Attempt.new(create_params)
            a.user_id = current_user_id
            if a.save
                flash[:notice] = "Attempt submitted successfully!"
                redirect_to problems_path
            else
                flash[:warning] = "Attempt couldn't be submitted"
                redirect_to new_attempt_path
            end
        end

private
        def create_params
            params.require(:submission)
        end
            
end
