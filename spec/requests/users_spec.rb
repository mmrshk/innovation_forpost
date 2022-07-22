# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admins/users', type: :request do
  let(:user) { create(:user, :super_admin) }

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
        expect(response).to redirect_to("#{admins_user_url(User.last)}?locale=#{I18n.locale}")
        follow_redirect!
        is_expected.to render_template(:show, notice: I18n.t('admins.users.create_success'))
        expect(response.body).to include(I18n.t('admins.users.create_success'))
      end
    end
    context 'with invalidparams' do
      let(:user_new_invalid) { build(:user, :invalid_params) }
      it 'should rerendrer the form' do
        expect(user_new_invalid).not_to be_valid
        # expect {post admins_users_path, params: {user: user_new_invalid}}.to change(User, :count).by(0)
      end
    end
  end

  describe 'put /update' do
    context 'with valid params' do
      let(:user_valid) { create(:user, :valid_params) }
      let(:edited_user_valid) { attributes_for(:user, :valid_params) }
      it 'should update the user' do
        put admins_user_path(user_valid), params: { user: edited_user_valid }
        is_expected.to redirect_to("#{admins_user_url(User.last)}?locale=#{I18n.locale}")
        follow_redirect!
        is_expected.to render_template(:show, notice: I18n.t('admins.users.update_success'))
        expect(response.body).to include(I18n.t('admins.users.update_success'))
      end
    end

    context 'with invalid params' do
      let(:user_valid) { create(:user, :valid_params) }
      let(:edited_user_invalid) { attributes_for(:user, :invalid_params) }
      it 'should not change the user' do
        put admins_user_path(user_valid), params: { user: edited_user_invalid }
        is_expected.to render_template(:edit, status: :unprocessable_entity)
      end
    end
  end

  describe 'delete /destroy' do
    context 'existing user' do
      let!(:user_valid) { create(:user, :valid_params) }
      it 'should be destroyed' do
        expect { delete admins_user_path(user_valid), params: { user: user_valid } }.to change(User, :count).by(-1)
        is_expected.to redirect_to("#{admins_users_path}?locale=#{I18n.locale}")
        follow_redirect!
        is_expected.to render_template(:index)
      end
    end
  end
end
