# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :articles, dependent: :nullify
  validates :email, presence: true
  validates :password, presence: true, allow_nil: true
  has_many  :articles
end
