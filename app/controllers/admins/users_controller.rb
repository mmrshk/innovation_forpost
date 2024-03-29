# frozen_string_literal: true

module Admins
  class UsersController < AdminsController
    before_action :user, only: %i[edit show update destroy]
    before_action :authenticate_user!, except: [:update]
    before_action :require_one_superadmin!, only: :update
    before_action :authorize_user, only: %i[show edit update destroy]

    def index
      @users = policy_scope(User)
      @q = @users.ransack(params[:q])
      @pagy, @users = pagy(@q.result)
    end

    def show; end

    def new
      @user = User.new
      authorize @user
    end

    def create
      @user = User.new(user_params)
      authorize @user
      if @user.save
        flash[:success] = I18n.t('admins.users.create_success')
        redirect_to admins_user_url(@user)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:success] = I18n.t('admins.users.users.update_success')
        redirect_to admins_user_url(@user)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @user == current_user
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

    def authorize_user
      authorize @user
    end

    def user_params
      params.require(:user).permit(:email, :phone_number, :role, :password, :password_confirmation)
    end

    def require_one_superadmin!
      return unless last_super_admin?

      flash[:success] = I18n.t('admins.users.super_admin_change_prohibited')
      redirect_to admins_user_url(@user)
    end

    def last_super_admin?
      user.current_user_last_super_admin? && params[:user][:role] != 'super_admin'
    end
  end
end
