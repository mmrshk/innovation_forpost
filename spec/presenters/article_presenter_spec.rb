# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlePresenter do
  include ActionView::TestCase::Behavior

  let(:tags_list)     { create_list(:tag, 2) }
  let(:valid_article) { create(:article, :published, :uk, :with_image_url_inside_text, tags: tags_list) }

  subject!(:article_presenter) { described_class.new(valid_article) }

  describe '#article' do
    
    it 'returns correct values' do
      expect(subject.article).to be valid_article
      expect(article_presenter).to be_an ArticlePresenter
      expect(article_presenter.all_tags).to eq(valid_article.tags.pluck(:name).join(', '))
      expect(article_presenter.article_preview_text.size).to be <= ArticlePresenter::LENGTH_TRUNCATE_DEFAULT
      expect(article_presenter.first_article_image).to eq '/uploads/ck_editor_image/file/1/clk1.jpeg'
      expect(article_presenter.article_preview_image).to match '<a href='
      expect(article_presenter.article_preview_image).to match '/uploads/ck_editor_image/file/1/clk1.jpeg'
      expect(article_presenter.color).to be 'green'
    end
  end
end
