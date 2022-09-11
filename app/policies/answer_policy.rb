# frozen_string_literal: true

class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.in_admin_group?
        scope.all
      else
        raise Pundit::NotAuthorizedError, 'not allowed to view this action'
      end
    end
  end

  def create?
    user.in_admin_group?
  end

  def destroy?
    user.role_super_admin?
  end
end
