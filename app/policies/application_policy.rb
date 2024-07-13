# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  authorize :user, optional: true
  pre_check :authenticate_user!

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    false
  end

  def update?
    false
  end

  def edit?
    false
  end

  def destroy?
    false
  end

  def manage?
    false
  end

  private

  def authenticate_user!
    deny! unless user.present?
  end
end
