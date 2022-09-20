# frozen_string_literal: true

class ResidentMailer < ApplicationMailer
  def new_resident_form
    @resident = params[:resident]

    mail(to: @resident.email)
  end
end
