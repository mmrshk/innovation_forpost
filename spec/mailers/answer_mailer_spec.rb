# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerMailer, type: :mailer do
  describe 'question_answered' do
    let(:mail) { AnswerMailer.question_answered }

    it 'renders the headers' do
      expect(mail.subject).to eq('Question answered')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
