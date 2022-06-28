class AdminsController < ApplicationController
  before_action :current_user
  
  def users_show
    @users ||= User.all
  end

  def articles_show
    #@articles ||= Articles.all
  end
end
