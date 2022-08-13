# frozen_string_literal: true

class User < ApplicationRecord
  USER_ROLES = {
    user: 0,
    admin: 1,
    super_admin: 2
  }.freeze

  enum role: USER_ROLES, _prefix: :role

  # Include default devise modules. Others available are:
  # :confirmable,  :lockable, :timeoutable, :trackable and :omniauthable
  scope :only_admins, -> { where(role: %i[super_admin admin]) }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy, foreign_key: 'user_id', inverse_of: :user

  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  scope :only_admins, -> { where(role: %i[super_admin admin]) }
end
