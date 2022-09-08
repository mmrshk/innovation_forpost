# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials[Rails.env.to_sym][:google_account][:SMTP_USERNAME]
  layout 'mailer'
end
