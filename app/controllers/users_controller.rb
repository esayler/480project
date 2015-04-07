class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @name = session["devise.google_data"]['info']['name']
    @email = session["devise.google_data"]['info']['email']
  end

  def edit
    @user = User.find(params[:id])
  end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update(create_update_params)
  #     flash[:notice] = "#{@user.name} was successfully updated."
  #     redirect_to root
  #   else
  #     flash[:warning] = "Update unsuccessfully"
  #     redirect_to root
  #   end
  # end

  private
    def create_update_params
      params.require(:name, :email)
    end

end
