# frozen_string_literal: true

module Admins
  class UsersController < AdminsController
    before_action :user, only: %i[edit show update destroy]
    helper_method :last_super_admin?

    def index
      @q = User.ransack(params[:q])
      @users = @q.result
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = I18n.t('admins.users.create_success')
        redirect_to admins_user_url(@user)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if last_super_admin_tries_to_update_its_role?
        flash[:success] = I18n.t('admins.users.super_admin_change_prohibited')
        redirect_to admins_user_url(@user)
      elsif @user.update(user_params)
        flash[:success] = I18n.t('admins.users.users.update_success')
        redirect_to admins_user_url(@user)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if last_super_admin_tries_to_destroy_itself?
        flash[:success] = I18n.t('admins.users.super_admin_change_prohibited')
      elsif authorized? && user.role_super_admin?
        flash[:success] = I18n.t('admins.users.current_user_account_destroy_prohibited')
      else
        @user.destroy
        flash[:success] = I18n.t('admins.users.user_sucessfully_deleted')
      end
      redirect_to admins_users_path
    end

    private

    def user
      @user ||= User.find(params[:id])
    end

    def authorized?
      @user == current_user
    end

    def last_super_admin_tries_to_update_its_role?
      user.role_super_admin? && last_super_admin? && (params[:user][:role] != 'super_admin')
    end

    def last_super_admin_tries_to_destroy_itself?
      user.role_super_admin? && last_super_admin?
    end

    def last_super_admin?
      @last_super_admin ||= User.where(role: User.roles[:super_admin]).size < 2
    end

    def user_params
      params.require(:user).permit(:email, :phone_number, :role, :password, :password_confirmation)
    end
  end
end
