# frozen_string_literal: true

class AttachmentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
        scope.all
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
