# frozen_string_literal: true

class TestNotifierMailer < ApplicationMailer
  # default from: 'Inno-Forpost <noreply-inno-forpost@example.com>',
  # return_path: 'inno-forpost@example.com'

  def test_sender(recepient)
    @user = recepient
    mail(to: @user.email, subject: "Test message for: #{@user.email}: Test Test Test Test Test Test")
  end
end
