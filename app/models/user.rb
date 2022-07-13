# frozen_string_literal: true

class User < ApplicationRecord
  # enum role: {user: 0, admin: 1, super_admin: 2} _suffix: true inprogress...
  # Include default devise modules. Others available are:
  # :confirmable,  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :articles, dependent: :nullify
  validates :email, presence: true
  validates :password, presence: true, allow_nil: true
end
