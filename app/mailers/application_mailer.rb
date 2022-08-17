# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('OUTLOOK_USERNAME')
  layout 'mailer'
end
