# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlePresenter do
  include ActionView::TestCase::Behavior

  subject { described_class.new(valid_article) }

  let(:tags_list)     { create_list(:tag, 2) }
  let(:valid_article) { create(:article, :published, :uk, :with_image_url_inside_text, tags: tags_list) }

  describe '#article' do
    it { expect(subject.article).to be valid_article }
    it { expect(subject).to be_an ArticlePresenter }
    it { expect(subject.all_tags).to eq(valid_article.tags.pluck(:name).join(', ')) }
    it { expect(subject.article_preview_text.size).to be <= ArticlePresenter::LENGTH_TRUNCATE_DEFAULT }
    it { expect(subject.first_article_image).to eq '/uploads/ck_editor_image/file/1/clk1.jpeg' }
    it { expect(subject.article_preview_image).to match '<a href=' }
    it { expect(subject.article_preview_image).to match '/uploads/ck_editor_image/file/1/clk1.jpeg' }
    it { expect(subject.color).to be 'green' }
  end
end
