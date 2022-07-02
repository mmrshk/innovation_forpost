class AdminsController < ApplicationController
  before_action :current_user, :logged_in_user
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  



  def users_show
    if @logged_in_user.role == 'super_admin'
    @users ||= User.all
    end
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
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path    
  end

  
  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

    def logged_in_user
      @logged_in_user = current_user
    end

    def user_params
      params.require(:user).permit(:name, :email, :phone_number, :role, :password, :password_confirmation)
    end
end
