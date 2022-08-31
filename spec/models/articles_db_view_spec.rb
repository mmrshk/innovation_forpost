# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesDbView, type: :model do
  describe 'ArticleDbView behaviour. ' do
    subject { described_class.all }

    let!(:article_work) { create(:article, :published, :user_example_id) }
    let!(:tag) { create(:tag, :work_tag) }
    let(:article_tag_work) do
      { article_id: article_work.id,
        tag_id: tag.id }
    end
    let!(:article_tag) { create(:article_tag, article_tag_work) }

    it 'Should show articles with certain tags' do
      # raise [article_work, tag, article_tag].inspect
      expect(subject.count).to eq(1)
    end
  end

  describe 'ArticleDbView behaviour. ' do
    subject { described_class.all }

    let!(:article_work) { create(:article, :published) }
    let!(:tag) { create(:tag, :work_tag) }
    let(:article_tag_work) do
      { article_id: article_work.id,
        tag_id: tag.id }
    end
    let!(:article_tag) { create(:article_tag, article_tag_work) }

    it 'Should not show articles with certain tags' do
      # raise [article_work, tag, article_tag].inspect
      expect(subject.count).to eq(0)
    end
  end
end
