# frozen_string_literal: true

class AnswerMailerPreview < ActionMailer::Preview
  def question_answered
    I18n.with_locale(@answer.language) do
      AnswerMailer.with(Answer.last, Question.last, admin: @admin).question_answered
    end
  end
end
