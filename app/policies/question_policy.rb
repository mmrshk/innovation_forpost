class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.in_admin_group?
        scope.all
      elsif user.present?
        scope.where(user_id: user.id)
      else
        raise Pundit::NotAuthorizedError, 'not allowed to view this action'
      end
    end
  end

  def show?
    user.in_admin_group? || resource.user == user
  end

  def update?
    user.role_super_admin? || resource.user == user
  end

  def destroy?
    user.role_super_admin? || resource.user == user
  end
end
