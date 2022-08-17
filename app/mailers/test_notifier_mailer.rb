# frozen_string_literal: true

class TestNotifierMailer < ApplicationMailer
  # default from: 'Inno-Forpost <noreply-inno-forpost@example.com>',
  # return_path: 'inno-forpost@example.com'

  def test_sender(recepient)
    # binding pry
    @user = recepient
    mail(to: @user.email, subject: "Dear #{@user.email}. You have got this message on a permanent base as a part of a mail notification.")
  end
end
