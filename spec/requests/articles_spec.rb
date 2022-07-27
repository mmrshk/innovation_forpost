# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let(:admin) { create(:user, :super_admin) }
  before do
    sign_in admin
  end

  describe 'GET /admins/articles#index' do
    it 'renders a successful response' do
      sign_in admin
      get admins_articles_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /en/articles#show' do
    let(:valid_article) { create(:article) }

    it 'renders a successful response' do
      get article_url(valid_article, locale: 'uk')
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /admins/articles#new' do
    it 'renders a successful response' do
      get new_admins_article_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /admins/articles#create' do
    context 'with valid parameters' do
      let(:valid_article) { attributes_for(:article, :published, :uk, tags: create_list(:tag, 2)) }

      it 'creates a new Article' do
        post admins_articles_url, params: { article: valid_article }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(assigns(:article))
        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(response.body).to include(I18n.t('admins.articles.create_success'))
      end

      it 'creates a new instance of Article with correct values' do
        expect { post admins_articles_url, params: { article: valid_article } }.to change(Article, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_article) { build(:article, :invalid_article) }
      let(:invalid_params) { attributes_for(:article, :invalid_article) }

      it 'does not create a new Article' do
        expect { post admins_articles_url, params: { article: invalid_params } }.not_to change(Article, :count)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        get new_admins_article_url
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
        post admins_articles_url, params: { article: invalid_params }
        expect(invalid_article).not_to be_valid
        expect(response).to have_http_status(422)
        expect(response).to render_template(:new)
        expect(response.body).to include(I18n.t('admins.articles.create_unsuccess'))
      end
    end
  end

  describe 'GET /admins/articles#edit' do
    let(:valid_article) { create(:article) }

    it 'render a successful response' do
      get edit_admins_article_url(valid_article)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let!(:valid_article) { create(:article, :en, :draft) }
      let(:valid_params) do
        {
          title: Faker::Lorem.characters(number: 10),
          text: Faker::Lorem.characters(number: 20),
          user_id: (create :user).id,
          language: 'uk',
          status: 'published'
        }
      end

      it 'updates the requested article' do
        get edit_admins_article_url(valid_article)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
        patch admins_article_url(valid_article), params: { article: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admins_articles_url(locale: I18n.locale))
        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(response.body).to include(I18n.t('admins.articles.update_success'))
      end
    end

    context 'with invalid parameters' do
      let!(:valid_article) { create(:article) }
      let(:invalid_params) { attributes_for(:article, :invalid_article) }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        get edit_admins_article_url(valid_article)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
        patch admins_article_url(valid_article), params: { article: invalid_params }
        expect(response).to have_http_status(422)
        expect(response).to render_template(:edit)
        expect(response.body).to include(I18n.t('admins.articles.update_unsuccess'))
      end
    end
  end

  describe 'DELETE /admins/articles#destroy' do
    let!(:valid_article) { create(:article) }

    it 'destroys the requested article' do
      expect { delete admins_article_url(valid_article) }.to change(Article, :count).by(-1)
    end

    it 'redirects to the articles list' do
      delete admins_article_url(valid_article)
      expect(response).to redirect_to(admins_articles_url(locale: I18n.locale)) # need to fix locale in admins_urls
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include(I18n.t('admins.articles.destroy_success'))
    end
  end
end
