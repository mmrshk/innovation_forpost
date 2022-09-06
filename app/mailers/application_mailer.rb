# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'innovation.forpost@gmail.com'
  layout 'mailer'
end
