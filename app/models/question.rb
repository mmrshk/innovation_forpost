# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }
  validates :body, presence: true, length: { minimum: 2, maximum: 1000 }
  validates :user_name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :user_email, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }, if: proc { |question|
                                                                                                      question.user_email.present?
                                                                                                    }
end
