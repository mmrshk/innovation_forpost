# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admins/articles').to route_to('admins/articles#index')
    end

    it 'routes to #new' do
      expect(get: '/admins/articles/new').to route_to('admins/articles#new')
    end

    it 'routes to #show' do
      expect(get: '/articles/1').to route_to('articles#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admins/articles/1/edit').to route_to('admins/articles#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admins/articles').to route_to('admins/articles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admins/articles/1').to route_to('admins/articles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admins/articles/1').to route_to('admins/articles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admins/articles/1').to route_to('admins/articles#destroy', id: '1')
    end
  end
end
