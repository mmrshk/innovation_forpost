# frozen_string_literal: true

class AnswerMailer < ApplicationMailer
  def question_answered
    @question = params[:question]
    @answer = params[:answer]
    @admin = params[:admin]

    I18n.with_locale(@answer.language) do
      mail(to: @question.user_email)
    end
  end
end
