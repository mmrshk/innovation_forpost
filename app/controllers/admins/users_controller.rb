module Admins
  class UsersController < AdminsController
    before_action :current_user, :logged_in_user
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]



    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.role = 'user'
    end 

    def edit
    end

    def update
      unless User.find_by(id: params[:id]).role == 'super_admin' && last_super_admin? && params[:user][:role] != 'super_admin'
        if @user.update(user_params)
          redirect_to admins_user_url(@user), notice: "User was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
      else
        redirect_to admins_user_url(@user), notice: "You cannot change a super_admin status being the last one."
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

    def user_params
      params.require(:user).permit(:name, :email, :phone_number, :role, :password, :password_confirmation)
    end

  end
  
end