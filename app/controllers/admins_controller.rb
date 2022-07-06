class AdminsController < ApplicationController
  before_action :current_user, :super_admin?, :admin?
  before_action :authenticate_user!
  
  helper_method :super_admin?, :admin?, :last_super_admin?
  
  

  private
    
  def super_admin?
    current_user.role == 'super_admin'
  end
  
  def admin?
    current_user.role == 'admin'
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
  
  def last_super_admin?
    super_admin_count = 0
    @users ||= User.all
    @users.map { |user|
      super_admin_count += 1 if user.role == 'super_admin'
    }
    true if super_admin_count < 2
  end
  
end
