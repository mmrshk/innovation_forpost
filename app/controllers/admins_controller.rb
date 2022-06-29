class AdminsController < ApplicationController
  before_action :current_user
  
  def users_show
    if super_admin?
      @users ||= User.all
    end
  end

  def articles_show
    if super_admin? || admin?
      #@articles ||= Articles.all
    end
  end
end
