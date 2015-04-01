class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]

  def index
  	byebug
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
	if @user.update(create_update_params)
		flash[:notice] = "#{@user.name} was successfully updated."
		redirect_to root
	else
		flash[:warning] = "Update unsuccessfully"
		redirect_to root
	end
  end
end
