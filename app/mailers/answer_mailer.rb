# frozen_string_literal: true

class AnswerMailer < ApplicationMailer
  def question_answered
    @question = params[:question]
    @answer = params[:answer]
    @admin = params[:admin]
    @greeting = t('admins.question_mailers.greeting')

    mail(
      from: Rails.application.credentials.google_account[:SMTP_USERNAME],
      to: @question.user_email
    )
  end
end
