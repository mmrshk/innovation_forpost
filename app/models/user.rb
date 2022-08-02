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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy, foreign_key: 'user_id', inverse_of: :user

  validates :email, presence: true
<<<<<<< HEAD
  validates :password, presence: true, allow_nil: true

  scope :only_admins, -> { where(role: %i[super_admin admin]) }
=======
  validates :password, presence: true
  validates :password_confirmation, presence: true
>>>>>>> 0a63c90851651f517d2f8952db4642be2419102c
end
