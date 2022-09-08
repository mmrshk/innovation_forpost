# frozen_string_literal: true

class AttachmentPolicy < ApplicationPolicy
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
    user.role_super_admin?
  end

  def destroy?
    user.role_super_admin?
  end
end
