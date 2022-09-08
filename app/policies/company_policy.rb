# frozen_string_literal: true

class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.in_admin_group?
        scope.all
      else
        raise Pundit::NotAuthorizedError, 'not allowed to view this action'
      end
    end
  end

  def index
    user.in_admin_group?
  end

  def show?
    true
  end

  def create?
    user.in_admin_group?
  end

  def update?
    user.in_admin_group?
  end

  def destroy?
    user.in_admin_group?
  end
end
