# frozen_string_literal: true

module Admins
  class UsersController < AdminsController
    before_action :user, only: %i[edit show update destroy]
    before_action :authenticate_user!, except: [:update]

    def index
      @users = if params[:sort] && User.column_names.include?(params[:sort])
                 User.order(params[:sort])
               else
                 User.all
               end
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

    # rubocop:disable Metrics/AbcSize
    def update
      if user.current_user_last_super_admin? && params[:user][:role] != 'super_admin'
        flash[:success] = I18n.t('admins.users.super_admin_change_prohibited')
        redirect_to admins_user_url(@user)
      elsif @user.update(user_params)
        flash[:success] = I18n.t('admins.users.users.update_success')
        redirect_to admins_user_url(@user)
      else
        render :edit, status: :unprocessable_entity
      end
    end
    # rubocop:enable Metrics/AbcSize

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

    def user_params
      params.require(:user).permit(:email, :phone_number, :role, :password, :password_confirmation)
    end
  end
end
