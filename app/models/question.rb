# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  scope :without_answer, -> { Question.left_outer_joins(:answers).where(answers: { id: nil }) }

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }
  validates :body, presence: true, length: { minimum: 2, maximum: 1000 }
  validates :user_name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :user_email, length: { maximum: 255 }
  validates :user_email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: proc { |question|
                                                                            question.user_email.present?
                                                                          }
end
