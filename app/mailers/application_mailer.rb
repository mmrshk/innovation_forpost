# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.google_account[:SMTP_user_name]
  layout 'mailer'
end
