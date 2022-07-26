# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admins/users', type: :request do
  let(:user) { create(:user, :role_super_admin) }
  let(:invalid_user) do
    { email: 'no_at_at_all.com',
      password: Faker::Internet.password(max_length: 5),
      password_confirmation: '',
      role: :user }
  end

  before(:each) { sign_in(user) }

  describe 'get /index' do
    it 'renders successful response' do
      get admins_users_path
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'get /show' do
    it 'should render users/show' do
      get admins_user_path(user)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'get /new' do
    it 'should render users/new' do
      get new_admins_user_path
      is_expected.to render_template(:new)
    end
  end

  describe 'get /edit' do
    it 'should render users/edit' do
      get edit_admins_user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'post /create' do
    context 'with valid params' do
      let(:user_new_valid) { attributes_for(:user, :valid_params) }

      it 'should create a user' do
        expect { post admins_users_path, params: { user: user_new_valid } }.to change(User, :count).by(1)
        expect(response).to redirect_to(admins_user_url(User.last, locale: I18n.locale))

        follow_redirect!

        is_expected.to render_template(:show, notice: I18n.t('admins.users.create_success'))
        expect(response.body).to include(I18n.t('admins.users.create_success'))
      end
    end

    context 'with invalid params' do
      let(:user_new_invalid) { build(:user, invalid_user) }

      it 'should rerendrer the form' do
        expect(user_new_invalid).not_to be_valid
        expect { user_new_invalid.save }.to change(User, :count).by(0)
      end
    end
  end

  describe 'put /update' do
    context 'with valid params' do
      let(:user_valid) { create(:user, :valid_params) }
      let(:edited_user_valid) { attributes_for(:user, :valid_params) }

      it 'should update the user' do
        put admins_user_path(user_valid), params: { user: edited_user_valid }
        is_expected.to redirect_to(admins_user_url(user_valid, locale: I18n.locale))

        follow_redirect!

        is_expected.to render_template(:show, notice: I18n.t('admins.users.update_success'))
        expect(response.body).to include(I18n.t('admins.users.update_success'))
      end
    end

    context 'with invalid params' do
      let(:user_valid) { create(:user, :valid_params) }
      let(:edited_user_invalid) { attributes_for(:user, invalid_user) }

      it 'should not change the user' do
        put admins_user_path(user_valid), params: { user: edited_user_invalid }
        is_expected.to render_template(:edit, status: :unprocessable_entity)
      end
    end

    context 'last super_admin who try to change its status' do
      let(:edited_last_super_admin) { attributes_for(:user, :role_user) }

      it 'should not change the last super_admin role' do
        put admins_user_path(user), params: { user: edited_last_super_admin }
        is_expected.to redirect_to(admins_user_path(user, locale: I18n.locale))

        follow_redirect!

        expect(response.body).to include(I18n.t('admins.users.super_admin_change_prohibited'))
      end
    end

    context 'not last super_admin changes its status' do
      let(:second_super_admin) { create(:user, :role_super_admin) }
      let(:edited_super_admin) { attributes_for(:user, :role_user) }

      it 'should change super_admin role' do
        put admins_user_path(second_super_admin), params: { user: edited_super_admin }
        is_expected.to redirect_to(admins_user_path(second_super_admin, locale: I18n.locale))

        follow_redirect!

        expect(response.body).to include(I18n.t('admins.users.update_success'))
      end
    end
  end

  describe 'delete /destroy' do
    context 'existing user' do
      let!(:user_valid) { create(:user, :valid_params) }

      it 'should be destroyed' do
        expect { delete admins_user_path(user_valid), params: { user: user_valid } }.to change(User, :count).by(-1)
        is_expected.to redirect_to(admins_users_path(locale: I18n.locale))

        follow_redirect!

        expect(response.body).to include(I18n.t('admins.users.user_sucessfully_deleted'))
      end
    end

    context 'last super_admin' do
      it 'should not be destroyed' do
        expect { delete admins_user_path(user), params: { user: user } }.to change(User, :count).by(0)
        is_expected.to redirect_to(admins_users_path(locale: I18n.locale))

        follow_redirect!

        expect(response.body).to include(I18n.t('admins.users.super_admin_change_prohibited'))
      end
    end

    context 'not last super_admin' do
      let!(:second_super_admin) { create(:user, :role_super_admin) }

      it 'should be destroyed' do
        expect do
          delete admins_user_path(second_super_admin), params: { user: second_super_admin }
        end.to change(User, :count).by(-1)
        is_expected.to redirect_to(admins_users_path(locale: I18n.locale))

        follow_redirect!

        expect(response.body).to include(I18n.t('admins.users.user_sucessfully_deleted'))
      end
    end

    context 'itself forbidden' do
      let!(:second_super_admin) { create(:user, :role_super_admin) }

      it 'user should not be destroyed' do
        expect { delete admins_user_path(user), params: { user: user } }.to change(User, :count).by(0)
        is_expected.to redirect_to(admins_users_path(locale: I18n.locale))

        follow_redirect!

        expect(response.body).to include(I18n.t('admins.users.current_user_account_destroy_prohibited'))
      end
    end
  end
end
