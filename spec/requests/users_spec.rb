# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admins/users', type: :request do
  let!(:user) { create(:user, :super_admin) }

  before(:each) { sign_in(user) }

  describe 'get /index' do
    it 'renders successful response' do
      get admins_users_path
      expect(response).to have_http_status(:success)
    end
  end
end
