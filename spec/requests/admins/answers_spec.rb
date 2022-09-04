# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Answers', type: :request do
  let!(:question) { create(:question, answers: [answer]) }
  let!(:answer) { create(:answer) }

  let(:admin) { create(:user, :super_admin) }

  before do
    sign_in admin
  end

  describe 'DELETE /destroy' do
    let(:params) { attributes_for(:answer) }

    it 'delete answer' do
      delete admins_question_answer_path(question, answer)
      expect(response).to redirect_to admins_question_path(locale: I18n.locale)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:params) { attributes_for(:answer) }

      it 'enqueue actionmailer' do
        expect { post admins_question_answers_path(question), params: { answer: params } }.to have_enqueued_job {
                                                                                                ActionMailer::DeliveryJob
                                                                                              }
      end

      let(:valid_answer) { attributes_for(:answer) }

      it 'creates a new instance of Answer with correct values' do
        expect do
          post admins_question_answers_url(question), params: { answer: valid_answer }
        end.to change(Answer, :count).by(1)
      end

      it 'create answer with valid params' do
        post admins_question_answers_path(question), params: { answer: params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to admins_question_path(question, locale: I18n.locale)
        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(response.body).to include('Answer created!')
      end
    end
    context 'with invalid parameters' do
      let(:invalid_answer) { attributes_for(:answer, :invalid_answer) }
      it 'creates a new instance of Question with incorrect values' do
        expect do
          post admins_question_answers_url(question), params: { answer: invalid_answer }
        end.not_to change(Answer, :count)
      end
    end
  end
end
