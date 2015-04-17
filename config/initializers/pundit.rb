module PunditHelper
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    flash[:alert] = "You aren't authorized to do that!"
    redirect_to (request.referrer || root_path)
  end

end

ApplicationController.send :include, PunditHelper
