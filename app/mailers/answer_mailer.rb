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
    @admin = params[:admin]
    @greeting = 'Hi'

    mail(
      from: 'bogdanrymar03@outlook.com',
      to: @question.user_email
    )
  end
end
