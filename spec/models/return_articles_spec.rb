# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReturnArticle, type: :model do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:tag) { create(:tag) }
  let!(:article_tag) { create(:article_tag, article: article, tag: tag) }
  let!(:ck_editor_image) { create(:ck_editor_image) }
  let(:record) { ReturnArticle.all.to_a.first }

  context 'with a valid data' do
    it 'returns a record', :truncation_mode do
      expect(ReturnArticle.count).to eq(1)
    end
  end

  context 'with attached file' do
    it 'return a record' do
      expect(record.images_count).to eq(1)
      expect(record.language).to eq(article.read_attribute_before_type_cast(:language))
    end
  end
  
end
