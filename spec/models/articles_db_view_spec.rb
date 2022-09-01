# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesDbView, type: :model do
  
  tag_set = %w(work робота Work Робота)
  let(:user_data_valid)       do { email: 'admin@example.com' } end
  let(:article_work_valid)    do { user_id: user_valid.id } end
  let(:article_invalid_date)  do { user_id: user_valid.id, created_at: (Time.now - 15.days) } end
  let(:tag_work)              do { name: tag_set.sample } end
  let(:tag_invalid)           do { name: 'not_a_work' } end
  let(:article_tag_work)      do { article_id: article.id, tag_id: tag.id } end
  
  describe 'ArticleDbView right behaviour with correct tags. ' do
    subject { described_class.all }
    let!(:user_valid)   { create(:user, :admin, user_data_valid) }
    let!(:article)      { create(:article, :published, article_work_valid) }
    
    tag_set.map do |tag_item|
      let!(:tag)          { create(:tag, name: tag_item) }
      let!(:article_tag)  { create(:article_tag, article_tag_work) }

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
