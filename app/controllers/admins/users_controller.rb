# frozen_string_literal: true

module Admins
  class UsersController < AdminsController
    before_action :user, :super_admin, only: %i[index show edit update destroy]
    helper_method :super_admin?, :admin?, :last_super_admin?

    def index
      @users = User.all
    end

    def show; end

    def new
      @user = User.new
      @path = '/admins/users'
    end

    def create
      @user = User.new(user_params)
      @user.role = ROW_USER
      if @user.save
        redirect_to root_path, notice: CREATE_SUCCESS
      else
        @path = '/admins/users'
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @path = "/admins/users/#{@user.id}"
    end

    def update
      last_super_admin_update
    end

    def destroy
      @user.destroy
      redirect_to root_path
    end

    private

    def user
      @user ||= User.find_by(id: params[:id])
    end

    def super_admin
      return true if super_admin?
      return render 'admins/users/access_denied', notice: PROHIBITED_ACCESS if user_signed_in?

      redirect_to new_user_session, notice: LogInFirst
    end

    def last_super_admin_update
      role = SUPER_ADMIN
      if User.find_by(id: params[:id]).role_super_admin? && last_super_admin? && params[:user][:role] == role
        return redirect_to admins_user_url(@user), notice: SUPER_ADMIN_CHANGE_PROHIBITED
      end
      return redirect_to admins_user_url(@user), notice: UPDATE_SUCCESS if @user.update(user_params)

      render :edit, status: :unprocessable_entity
    end

    def super_admin?
      return true if current_user.role_super_admin?

      false
    end

    def admin?
      return true if current_user.role_admin?

      false
    end

    def last_super_admin?
      @users ||= User.all
      return true if @users.where(role: SUPER_ADMIN).count < 2

      false
    end

    def user_params
      params.require(:user).permit(:email, :phone_number, :role, :password, :password_confirmation)
    end
  end
end
