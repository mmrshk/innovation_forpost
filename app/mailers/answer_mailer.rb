# frozen_string_literal: true

class AnswerMailer < ApplicationMailer
  def question_answered
    @question = params[:question]
    @answer = params[:answer]
    @admin = params[:admin]
    @greeting = 'Hi'

    mail(
      from: Rails.application.credentials[Rails.env.to_sym][:google_account][:SMTP_USERNAME],
      to: @question.user_email
    )
  end
end
