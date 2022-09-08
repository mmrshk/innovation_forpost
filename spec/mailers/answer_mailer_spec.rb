# frozen_string_literal: true

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswerMailer, type: :mailer do
  before do
    subject.from = sender_email
  end

  describe 'question_answered' do
    subject { described_class.with(answer: answer, question: question, admin: answered_by).question_answered }
    let(:answer) { create(:answer) }
    let(:question) { create(:question) }
    let(:answered_by) { create(:user, :admin) }
    let(:sender_email) { Faker::Internet.email }

    it 'renders the headers' do
      expect(subject.subject).to eq('Question answered')
      expect(subject.to).to eq([question.user_email])
      expect(subject.from).to eq([sender_email])
    end

    it 'contains necessary info' do
      expect(subject.body.encoded).to match(question.title)
      expect(subject.body.encoded).to match(question.body)
      expect(subject.body.encoded).to match(answer.body)
    end
  end
end
