# frozen_string_literal: true

class User < ApplicationRecord
  enum role: { user: 'user', admin: 'admin', super_admin: 'super_admin' }, _prefix: :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :articles, dependent: :nullify
  validates :email, presence: true
  validates :password, presence: true, allow_nil: true
end
