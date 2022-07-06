module Admins
  class UsersController < AdminsController
    before_action :current_user, :super_admin?
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :super_admin?, only: [:index, :edit, :update, :destroy]



    def index
      @users = User.all if super_admin?
    end

    def show
    end

    def new
      @user = User.new
      @path = '/admins/users'
    end
    
    def create
      @user = User.new(user_params)
      @user.role = 'user'
      if @user.save
        redirect_to root_path
      else
        render :edit, status: :unprocessable_entity
        redirect_to root_path
      end
    end 

    def edit
      @path = "/admins/users/#{@user.id}"
    end

    def update
      if User.find_by(id: params[:id]).role == 'super_admin' && last_super_admin? && params[:user][:role] == 'super_admin'
        redirect_to admins_user_url(@user), notice: "You cannot change a super_admin status being the last one."
      else
        if @user.update(user_params)
          redirect_to admins_user_url(@user), notice: "User was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
      end
    end

    def destroy
      @user.destroy
      redirect_to root_path    
    end


    private

    def user_params
      params.require(:user).permit(:name, :email, :phone_number, :role, :password, :password_confirmation)
    end

  end
  
end