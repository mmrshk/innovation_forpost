# frozen_string_literal: true

module Admins
  class UsersController < AdminsController
    before_action :user, only: %i[edit show update]
    helper_method :last_super_admin?

    def index
      @users = User.all
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to admins_user_url(@user), notice: ''
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      redirect_to admins_user_url(@user), notice: '' if last_super_admin_tries_to_update_its_role?

      if @user.update(user_params)
        redirect_to admins_user_url(@user), notice: '' 
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy

      redirect_to admins_users_path
    end

    private

    def user
      @user ||= User.find_by(id: params[:id])
    end

    def last_super_admin_tries_to_update_its_role?
      user.role_super_admin? && last_super_admin? && params[:user][:role] == User::USER_ROLES[:super_admin]
    end

    def last_super_admin?
      @last_super_admin ||= begin
        super_admins = User.where(role: User::USER_ROLES[:super_admin]).size 
        super_admins < 2
      end
    end

    def user_params
      params.require(:user).permit(:email, :phone_number, :role, :password, :password_confirmation)
    end
  end
end
