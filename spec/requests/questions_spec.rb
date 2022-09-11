# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  describe 'GET /questions#index' do
    it 'renders a successful response' do
      get questions_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /uk/questions#show' do
    let(:valid_question) { create(:question) }

    it 'renders a successful response' do
      get question_url(valid_question, locale: 'uk')
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /questions#new' do
    it 'renders a successful response' do
      get new_question_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /questions#create' do
    context 'with valid parameters' do
      let(:valid_question) { attributes_for(:question) }

      it 'creates a new Question' do
        post questions_url, params: { question: valid_question }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(questions_url)
        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(response.body).to include(I18n.t('admins.questions.create'))
      end

      it 'creates a new instance of Question with correct values' do
        expect { post questions_url, params: { question: valid_question } }.to change(Question, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_question) { build(:question, :question_with_invalid_email) }
      let(:invalid_params) { attributes_for(:question, :question_with_invalid_email) }

      it 'does not create a new Question' do
        expect { post questions_url, params: { question: invalid_params } }.not_to change(Question, :count)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        get new_question_url
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
        post questions_url, params: { question: invalid_params }
        expect(invalid_question).not_to be_valid
        expect(response).to have_http_status(422)
        expect(response).to render_template(:new)
      end
    end
  end

  let(:admin) { create(:user, :super_admin) }

  before do
    sign_in admin
  end

  describe 'DELETE /admins/questions#destroy' do
    let!(:valid_question) { create(:question) }
    it 'destroys the requested question' do
      expect { delete admins_question_url(valid_question) }.to change(Question, :count).by(-1)
    end

    it 'redirects to the questions list' do
      delete admins_question_url(valid_question)
      expect(response).to redirect_to(admins_questions_url(locale: I18n.locale))
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end
end
