class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user = current_user
    @user = model
  end

  def index?
    true
    #@current_user.admin? or @current_user.alum? or @current_user.prof?
  end

  def show?
    @current_user.admin? or @current_user == @user or @current_user.alum? or @current_user.prof?
  end

  def edit?
    @current_user.admin?
  end

  def update?
    true
    #@current_user.admin?
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin?
  end
end

class Scope < Struct.new(:current_user, :model)
  def resolve
    if current_user.admin? or current_user.alum? or current_user.prof?
      model.all
    else
      #model.where(role: current_user.role)
      model.all
    end
  end
end
