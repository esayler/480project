class AttemptPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user = current_user
    @attempt = model
  end

  def edit?
    @current_user.admin? or @current_user.alum? or @current_user.prof? or @current_user.id != @attempt.user_id
  end

  def update?
    @current_user.admin? or @current_user.alum? or @current_user.prof? or @current_user.id != @attempt.user_id
  end

  def destroy?
    @current_user.admin?
  end
end
