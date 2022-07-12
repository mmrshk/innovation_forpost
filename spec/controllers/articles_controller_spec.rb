# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::ArticlesController, type: :controller do
  # before do
  #   allow(controller).to receive(:authenticate_user!).and_return(true)
  #   allow(controller).to receive(:current_user).and_return(current_user)

  #   request
  # end

  describe 'GET admins/articles#new' do
    subject(:request) { get :new }

    context 'when admin authorized' do
      let!(:current_user) { create(:admin) }

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end

      it 'doesn`t set a flash message' do
        expect(flash['alert']).to be_nil
      end
    end

    context 'when reader authorized' do
      let!(:current_user) { create(:reader) }

      include_examples 'returns not authorized error'
    end
  end

  describe 'GET admins/articles#edit' do
    subject(:request) { get :edit, params: { id: article.id } }

    let(:admin) { create(:admin) }
    let(:article) { create(:article, user_id: admin.id) }

    context 'when admin authorized' do
      let!(:current_user) { create(:admin) }

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end

      it 'doesn`t set a flash message' do
        expect(flash['alert']).to be_nil
      end
    end

    context 'when reader authorized' do
      let!(:current_user) { create(:reader) }

      include_examples 'returns not authorized error'
    end
  end

  describe 'POST admins/articles#create' do
    subject(:request) { post :create, params: articles_params }

    let(:articles_params) do
      {
        articles_form: {
          content: content,
          category: category,
          article_tags: { tag_ids: tags.pluck(:id) }
        }
      }
    end

    context 'when params are valid' do
      let(:tags) { create_list(:tag, 2) }
      let(:content) { FFaker::Lorem.paragraph }
      let(:category) { FFaker::Lorem.word }

      context 'when admin authorized' do
        let!(:current_user) { create(:admin) }

        it 'returns moved permanently status' do
          expect(response).to have_http_status(:found)
        end

        it 'sets a flash message' do
          expect(flash['notice']).to eq('New Article is created')
        end
      end

      context 'when reader authorized' do
        let!(:current_user) { create(:reader) }

        include_examples 'returns not authorized error'
      end
    end

    context 'when params are invalid' do
      let(:tags) { [] }
      let(:content) { '' }
      let(:category) { '' }

      context 'when admin authorized' do
        let!(:current_user) { create(:admin) }

        it 'returns moved permanently status' do
          expect(response).to have_http_status(:success)
        end

        it 'doesn`t set a flash message' do
          expect(flash['notice']).to be_nil
        end
      end

      context 'when reader authorized' do
        let!(:current_user) { create(:reader) }

        include_examples 'returns not authorized error'
      end
    end
  end

  describe 'PUT admins/articles#update' do
    subject(:request) { put :update, params: articles_params }

    let(:admin) { create(:admin) }
    let(:article) { create(:article, user_id: admin.id) }

    let(:articles_params) do
      {
        id: article.id,
        articles_form: {
          content: content,
          category: category,
          article_tags: { tag_ids: tags.pluck(:id) }
        }
      }
    end

    context 'when params are valid' do
      let(:tags) { create_list(:tag, 2) }
      let(:content) { FFaker::Lorem.paragraph }
      let(:category) { FFaker::Lorem.word }

      context 'when admin authorized' do
        let!(:current_user) { admin }

        it 'returns moved permanently status' do
          expect(response).to have_http_status(:found)
        end

        it 'sets a flash message' do
          expect(flash['notice']).to eq('Article is updated')
        end
      end

      context 'when reader authorized' do
        let!(:current_user) { create(:reader) }

        include_examples 'returns not authorized error'
      end
    end

    context 'when params are invalid' do
      let(:tags) { [] }
      let(:content) { '' }
      let(:category) { '' }

      context 'when admin authorized' do
        let!(:current_user) { create(:admin) }

        it 'returns moved permanently status' do
          expect(response).to have_http_status(:success)
        end

        it 'doesn`t set a flash message' do
          expect(flash['notice']).to be_nil
        end
      end

      context 'when reader authorized' do
        let!(:current_user) { create(:reader) }

        include_examples 'returns not authorized error'
      end
    end
  end

  describe 'DELETE admins/articles#destroy' do
    subject(:request) { delete :destroy, params: { id: article.id } }

    let(:admin) { create(:admin) }
    let(:article) { create(:article, user_id: admin.id) }

    context 'when admin authorized' do
      let!(:current_user) { admin }

      it 'returns success status' do
        expect(response).to have_http_status(:found)
      end

      it 'sets a flash message' do
        expect(flash['notice']).to eq('Article is deleted')
      end

      it 'redirects to correct path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when reader authorized' do
      let!(:current_user) { create(:reader) }

      include_examples 'returns not authorized error'
    end
  end

  describe 'POST admins/articles#activate' do
    subject(:request) { post :activate, params: { id: article.id } }

    let(:admin) { create(:admin) }
    let(:article) { create(:article, user_id: admin.id) }

    context 'when admin authorized' do
      let!(:current_user) { admin }

      it 'returns success status' do
        expect(response).to have_http_status(:found)
      end

      it 'sets a flash message' do
        expect(flash['notice']).to eq('Article is activated')
      end

      it 'redirects to correct path' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when reader authorized' do
      let!(:current_user) { create(:reader) }

      include_examples 'returns not authorized error'
    end
  end
end
