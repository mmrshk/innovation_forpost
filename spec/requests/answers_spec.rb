# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Answers', type: :request do
  describe 'POST /answers#create' do
    # context 'with valid parameters' do
    #   let(:valid_answer) { attributes_for(:answer) }

    #   it 'creates a new Answer' do
    #     post admins_question_answer_url, params: { answer: valid_answer }
    #     expect(response).to have_http_status(:redirect)
    #     expect(response).to redirect_to(admins_question_answer_url)
    #     follow_redirect!
    #     expect(response).to have_http_status(:success)
    #     #expect(response).to render_template(:index)
    #     expect(response.body).to include('Answer created!')
    #   end

    #   it 'creates a new instance of Answer with correct values' do
    #     expect { post admins_question_answer_url, params: { answer: valid_answer } }.to change(Answer, :count).by(1)
    #   end
    # end

    # context 'with invalid parameters' do
    #   let(:invalid_question) { build(:question, :question_with_invalid_email) }
    #   let(:invalid_params) { attributes_for(:question, :question_with_invalid_email) }

    #   it 'does not create a new Question' do
    #     expect { post questions_url, params: { question: invalid_params } }.not_to change(Question, :count)
    #   end

    #   it "renders a successful response (i.e. to display the 'new' template)" do
    #     get new_question_url
    #     expect(response).to have_http_status(:success)
    #     expect(response).to render_template(:new)
    #     post questions_url, params: { question: invalid_params }
    #     expect(invalid_question).not_to be_valid
    #     expect(response).to have_http_status(422)
    #     expect(response).to render_template(:new)
    #   end
    # end
  end
end
