class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin? or @current_user.alum? or @current_user.prof?
  end

  def show?
    @current_user.admin? or @current_user == @user or @current_user.alum? or @current_user.prof?
  end

  def update?
    @current_user.admin?
  end

  def edit?
    @current_user.admin?
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin?
  end
end
