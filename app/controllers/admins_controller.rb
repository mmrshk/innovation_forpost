class AdminsController < ApplicationController
  before_action :current_user, :logged_in_user
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_if_super_admmin?, only: [:users_show, :edit, :update, :destroy]
  
  
  def users_show
    @users ||= User.all
  end

  def articles_show
    if @logged_in_user.role == 'super_admin' || 'admin'
      #@articles ||= Articles.all
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.role = 'user'
  end 

  def update
    if User.find_by(id: params[:id]).role == 'super_admin' && last_super_admin? && params[:user][:role] == 'super_admin'
      redirect_to user_url(@user), notice: "You cannot change a super_admin status being the last one."
    else
      if @user.update(user_params)
        redirect_to user_url(@user), notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @user.destroy unless last_super_admin?
    redirect_to root_path    
  end

  
  private
    
    def set_user
      @user ||= User.find(params[:id]) rescue not_found
    end

    def logged_in_user
      @logged_in_user = current_user
    end

    def check_if_super_admmin?
      true if @logged_in_user.role == 'super_admin'
    end

    def last_super_admin?
      super_admin_count = 0
      @users ||= User.all
      @users.map { |user|
        super_admin_count += 1 if user.role == 'super_admin'
      }
      true if super_admin_count < 2
    end

    def user_params
      params.require(:user).permit(:name, :email, :phone_number, :role, :password, :password_confirmation)
    end
end
