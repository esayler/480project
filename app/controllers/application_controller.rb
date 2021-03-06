class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    stored_location_for(resource)
    if resource.is_a?(User)
      problems_path
    else
      super
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << [:name]
    end

  private
    def record_not_found
      redirect_to :back, :alert => "404 - Record Not Found"
    end
end
