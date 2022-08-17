# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/answer_mailer
class AnswerMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/answer_mailer/question_answered
  def question_answered
    AnswerMailer.question_answered
  end
end
