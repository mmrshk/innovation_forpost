# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerMailer, type: :mailer do
  before do
    allow(Rails.application.credentials.google_account).to receive(:[]).with(:SMTP_USERNAME).and_return(sender_email)
  end
  describe 'question_answered' do
    let(:mail) { AnswerMailer.with(answer: answer, question: question, admin: answered_by).question_answered }
    let(:answer) { create(:answer) }
    let(:question) { create(:question) }
    let(:answered_by) { create(:user, :admin) }
    let(:sender_email) { Faker::Internet.email }

    it 'renders the headers' do
      expect(mail.subject).to eq('Question answered')
      expect(mail.to).to eq([question.user_email])
      expect(mail.from).to eq([sender_email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
