# frozen_string_literal: true

class ResidentMailer < ApplicationMailer
  def new_resident_form
    @resident = params[:resident]

    mail(
      from: Rails.application.credentials.google_account[:SMTP_USERNAME],
      to: @resident.email
    )
  end
end
