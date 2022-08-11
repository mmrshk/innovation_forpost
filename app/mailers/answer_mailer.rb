# frozen_string_literal: true

class AnswerMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.answer_mailer.question_answered.subject
  #
  def question_answered
    @question = params[:question]
    @answer = params[:answer]
    @greeting = 'Hi'

    mail(
      from: 'bogdan@gmail.com',
      to: Question.first.user_email,
      cc: Question.all.pluck(:user_email),
      subject: 'Your question answered'
    )
  end
end
