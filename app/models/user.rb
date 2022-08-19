# frozen_string_literal: true

class User < ApplicationRecord
  USER_ROLES = {
    user: 'user',
    admin: 'admin',
    super_admin: 'super_admin'
  }.freeze

  enum role: USER_ROLES, _prefix: :role

  # Include default devise modules. Others available are:
  # :confirmable,  :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy, foreign_key: 'user_id', inverse_of: :user

  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  scope :only_admins, -> { where(role: %i[super_admin admin]) }

  def current_user_last_super_admin?
    role_super_admin? && last_super_admin?
  end

  def last_super_admin?
    User.where(role: User.roles[:super_admin]).size == 1
  end
end
