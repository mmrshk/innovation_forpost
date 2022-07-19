# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /not_found' do
    it 'returns http not_found' do
      get '/404'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /unprocessable_entity' do
    it 'returns http unprocessable_entity' do
      get '/422'
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /internal_server_error' do
    it 'returns http internal_server_error' do
      get '/500'
      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
