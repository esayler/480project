module PunditHelper
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  #def user_not_authorized
    #flash[:alert] = "You aren't authorized to do that!"
    #redirect_to (request.referrer || root_path)
  #end

  #def user_not_authorized(exception)
    #policy_name = exception.policy.class.to_s
    #flash[:alert] = "Access denied by #{policy_name} for #{exception.record} #{exception.query.chop}"
    #redirect_to (request.referrer || root_path)
  #end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = I18n.t "pundit.#{policy_name}.#{exception.query}",
      default: 'You cannot perform this action.'
      redirect_to (request.referrer || root_path)
  end

end

ApplicationController.send :include, PunditHelper
