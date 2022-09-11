# frozen_string_literal: true

class AttachmentPolicy < ApplicationPolicy
  class Scope < Scope
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
