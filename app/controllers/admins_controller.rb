# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :authenticate_user!
  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  private

  def redirect_to_last_page(exception)
    redirect_to url_for(page: exception.pagy.last, items: params[:items])
  end
end
