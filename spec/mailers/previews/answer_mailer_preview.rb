# frozen_string_literal: true

class AnswerMailerPreview < ActionMailer::Preview
  def question_answered
    AnswerMailer.with(answer: @answer, question: @question, admin: @admin).question_answered
  end
end
