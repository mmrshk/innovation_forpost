# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'bogdanrymar03@outlook.com'
  layout 'mailer'
end
