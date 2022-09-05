# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReturnArticle, type: :model do
  let!(:user) { create(:user, email: 'admin@example.com') }
  let!(:article) { create(:article, user: user) }
  let!(:tag) { create(:tag, name: 'Work') }
  let!(:article_tag) { create(:article_tag, article: article, tag: tag) }

  context 'with a valid data' do
    it 'returns a record' do
      expect(ReturnArticle.count).to eq(1)
    end
  end

  context 'with too old article' do
    let!(:article) { create(:article, user: user, created_at: 5.weeks.ago) }

    it 'does not return a record' do
      expect(ReturnArticle.count).to eq(0)
    end
  end

  context 'with wrong user' do
    let!(:user) { create(:user, email: 'admin1@example.com') }

    it 'does not return a record' do
      expect(ReturnArticle.count).to eq(0)
    end
  end

  context 'with incorrect tag' do
    let!(:tag) { create(:tag, name: 'Job') }

    it 'does not return a record' do
      expect(ReturnArticle.count).to eq(0)
    end
  end
end
