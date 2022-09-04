# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlePresenter do
  let(:tags_list)      { create_list(:tag, 2) }
  let(:valid_article)  { attributes_for(:article, :published, :uk, tags: tags_list) }

  let(:article_params) do
    {
      title: valid_article[:title],
      text: valid_article[:text],
      user_id: valid_article[:user_id],
      status: valid_article[:status],
      language: valid_article[:language],
      tags: valid_article[:tags]
    }
  end

  subject(:article_presenter) { described_class.new(article_params) }

  describe '#article' do
    it 'returns correct values' do
      expect(subject.article[:title]).to    be valid_article[:title]
      expect(subject.article[:text]).to     be valid_article[:text]
      expect(subject.article[:user_id]).to  be valid_article[:user_id]
      expect(subject.article[:status]).to   be valid_article[:status]
      expect(subject.article[:language]).to be valid_article[:language]
      expect(subject.article).to            eq(valid_article)
      expect(article_presenter).to          be_a(ArticlePresenter)
    end
  end
end
