# frozen_string_literal: true

class AnswerMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.answer_mailer.question_answered.subject
  #
  def question_answered
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end
end
