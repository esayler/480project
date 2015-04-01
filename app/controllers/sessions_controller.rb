class SessionsController < ApplicationController

  def new
    # signin route
    redirect_to '/auth/google_oauth2'
  end

  def create
    auth = request.env["omniauth.auth"]
    # check db if user's data is there. if it's not there, create new user record
    user = User.find_by email: auth['user_info']['email']
    if !(user==nil)
      reset_session
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Signed in!'
    else
      redirect_to new_user_path
    end
  end

  def destroy
    # signout route
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    # authentication error (/auth/failure route)
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
