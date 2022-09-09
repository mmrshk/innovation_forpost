# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesDbView, type: :model do
  subject { described_class.all }
  let(:user_data_valid)       { { email: 'admin@example.com' } }
  let(:article_work_valid)    { { user_id: user_valid.id } }
  let(:article_invalid_date)  { { user_id: user_valid.id, created_at: (Time.now - 15.days) } }
  let(:tag_work)              { { name: %w[work робота Work Робота].sample } }
  let(:tag_invalid)           { { name: 'not_a_work' } }
  let(:article_tag_work)      { { article_id: article.id, tag_id: tag.id } }

  describe 'ArticleDbView right behaviour with correct tags. ' do
    let!(:user_valid)   { create(:user, :admin, user_data_valid) }
    let!(:article)      { create(:article, :published, article_work_valid) }
    let!(:article_tag)  { create(:article_tag, article_tag_work) }

    %w[work робота Work Робота].each do |tag_item|
      let!(:tag) { create(:tag, name: tag_item) }

      it 'Should show articles with a certain tag' do
        expect(subject.count).to eq(1)
      end
    end
  end

  describe 'ArticleDbView behaviour, wrong user.email. ' do
    subject { described_class.all }

    let!(:user_valid)   { create(:user, :admin) }
    let!(:article)      { create(:article, :published, article_work_valid) }
    let!(:tag)          { create(:tag, tag_work) }
    let!(:article_tag)  { create(:article_tag, article_tag_work) }

    it 'Should not show articles, wrong user.email' do
      expect(subject.count).to eq(0)
    end
  end

  describe 'ArticleDbView behaviour, wrong creating time. ' do
    subject { described_class.all }

    let!(:user_valid)   { create(:user, :admin, user_data_valid) }
    let!(:article)      { create(:article, :published, created_at: (Time.now - 15.days)) }
    let!(:tag)          { create(:tag, tag_work) }
    let!(:article_tag)  { create(:article_tag, article_tag_work) }

    it 'Should hide articles, obsolete date' do
      expect(subject.count).to eq(0)
    end
  end

  describe 'ArticleDbView behaviour, wrong tag set. ' do
    subject { described_class.all }

    let!(:user_valid)   { create(:user, :admin, user_data_valid) }
    let!(:article)      { create(:article, :published) }
    let!(:tag)          { create(:tag, tag_invalid) }
    let!(:article_tag)  { create(:article_tag, article_tag_work) }

    it 'Should hide articles with inappropiate tags' do
      expect(subject.count).to eq(0)
    end
  end
end
