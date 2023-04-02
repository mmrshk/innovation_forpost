# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization

  before_action :set_locale
  helper_method :unread_questions_size

  private

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale.to_sym : nil
  end

  def unread_questions_size
    Question.without_answer.size
  end
  
  rescue_from Pundit::NotAuthorizedError do |_exception|
    redirect_to root_path
    flash[:error] = I18n.t('admins.policy.authorized')
end
