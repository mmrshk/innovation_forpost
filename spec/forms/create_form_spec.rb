# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Articles::CreateUpdateForm do
  subject(:form) { described_class.new(params: article_params) }

  let(:tags_list) { create_list(:tag, 2) }
  let(:valid_article) { attributes_for(:article, :published, :uk, tags: tags_list) }
  let(:invalid_article) { attributes_for(:article, :invalid_article) }

  describe '#save creates successful' do
    context 'when params are correct' do
      let(:article_params) do
        {
          title: valid_article[:title],
          text: valid_article[:text],
          user_id: valid_article[:user_id],
          status: valid_article[:status],
          language: valid_article[:language],
          tags: valid_article[:tags].pluck(:name).join(', ')
        }
      end

      it 'changes Articles count' do
        expect { form.save }.to change(Article, :count).by(1)
      end

      it 'changes ArticleTags count' do
        expect { form.save }.to change(ArticleTag, :count).by(2)
        expect(Article.last.tags.count).to eq(2)
      end

      it 'creates a new instance of Article with correct values' do
        form.save
        created_article = Article.last
        expect(created_article.title).to eq(valid_article[:title])
        expect(created_article.text).to eq(valid_article[:text])
        expect(created_article.user_id).to eq(valid_article[:user_id])
        expect(created_article.status).to eq(valid_article[:status])
        expect(created_article.language).to eq(valid_article[:language])
        expect(created_article.tags).to eq(valid_article[:tags])
      end
    end
  end

  describe '#save creates unsuccessful' do
    context 'when params are invalid' do
      let(:article_params) do
        {
          title: invalid_article[:title],
          text: invalid_article[:text],
          user_id: invalid_article[:user_id],
          status: invalid_article[:status],
          language: invalid_article[:language],
          tags: invalid_article[:tags]
        }
      end

      it 'not changes Articles count' do
        expect { form.save }.not_to change(Article, :count)
      end

      it 'not changes ArticleTags count' do
        expect { form.save }.not_to change(ArticleTag, :count)
      end

      it 'returns false' do
        expect(form.save).to eq(false)
      end
    end

    context 'when raises error' do
      before { allow(Article).to receive(:create!).and_raise(ActiveRecord::RecordInvalid) }

      let(:article_params) do
        {
          title: invalid_article[:title],
          text: invalid_article[:text],
          user_id: invalid_article[:user_id],
          status: invalid_article[:status],
          language: invalid_article[:language],
          tags: invalid_article[:tags]
        }
      end

      it 'not changes Articles count' do
        expect { form.save }.not_to change(Article, :count)
      end

      it 'not changes ArticleTags count' do
        expect { form.save }.not_to change(ArticleTag, :count)
      end

      it 'returns false' do
        expect(form.save).to eq(false)
      end
    end
  end
end
