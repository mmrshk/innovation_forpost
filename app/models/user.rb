# frozen_string_literal: true

class User < ApplicationRecord
  USER_ROLES = {
    user: 'user',
    admin: 'admin',
    super_admin: 'super_admin'
  }.freeze

  enum role: { super_admin: 2, admin: 1, user: 0 }, _prefix: :role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :password, presence: true, allow_nil: true

  has_many  :articles, dependent: :nullify
end
