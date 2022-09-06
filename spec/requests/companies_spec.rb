# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  describe 'GET /companies#index' do
    it 'renders a successful response' do
      get companies_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end
end
