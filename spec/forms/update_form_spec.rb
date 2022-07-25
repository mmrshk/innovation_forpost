# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Articles::CreateUpdateForm do
  subject(:form) { described_class.new(params: article_params, article: article) }

  let(:tags_list) { create_list(:tag, 2) }
  let!(:article) { create(:article, :draft, :en, tags: tags_list) }
  let(:article_new_valid_params) { attributes_for(:article, :published, :uk, tags: create_list(:tag, 2)) }
  let(:invalid_article) { attributes_for(:article, :invalid_article, tags: create_list(:tag, 2)) }

  describe '#save update successful' do
    context 'when params are correct with only new tags' do
      let(:article_params) do
        {
          title: article_new_valid_params[:title],
          text: article_new_valid_params[:text],
          user_id: article_new_valid_params[:user_id],
          status: article_new_valid_params[:status],
          language: article_new_valid_params[:language],
          tags: article_new_valid_params[:tags].pluck(:name).join(', ')
        }
      end

      it 'not changes Articles count' do
        expect { form.save }.not_to change(Article, :count)
      end

      it 'not changes ArticleTags count' do
        expect { form.save }.not_to change(ArticleTag, :count)
        expect(Article.last.tags.count).to eq(2)
      end

      it 'updates the exist instance of Article with correct values' do
        form.save
        updated_article = Article.last
        expect(updated_article.id).to eq(article.id)
        expect(updated_article.title).to eq(article_new_valid_params[:title])
        expect(updated_article.text).to eq(article_new_valid_params[:text])
        expect(updated_article.user_id).to eq(article_new_valid_params[:user_id])
        expect(updated_article.status).to eq(article_new_valid_params[:status])
        expect(updated_article.language).to eq(article_new_valid_params[:language])
        expect(updated_article.tags).to eq(article_new_valid_params[:tags])
      end
    end

    context 'when params are correct with exist and new tags' do
      let(:article_params) do
        {
          title: article.title,
          text: article_new_valid_params[:text],
          user_id: article.user_id,
          status: article_new_valid_params[:status],
          language: article.language,
          tags: (article.tags.pluck(:name) + article_new_valid_params[:tags].pluck(:name)).join(', ')
        }
      end
      it 'not changes Articles count' do
        expect { form.save }.not_to change(Article, :count)
      end

      it 'changes ArticleTags count' do
        expect { form.save }.to change(ArticleTag, :count).by(2)
        expect(Article.last.tags.count).to eq(4)
      end

      it 'updates the exist instance of Article with correct values and new tags' do
        form.save
        updated_article = Article.last
        expect(updated_article.id).to eq(article.id)
        expect(updated_article.title).to eq(article_params[:title])
        expect(updated_article.text).to eq(article_params[:text])
        expect(updated_article.user_id).to eq(article_params[:user_id])
        expect(updated_article.status).to eq(article_params[:status])
        expect(updated_article.language).to eq(article_params[:language])
        expect(updated_article.tags.pluck(:name).join(', ')).to eq(article_params[:tags])
      end
    end
  end

  describe '#save update unsuccessful' do
    context 'when params are not correct' do
      let(:article_params) do
        {
          title: invalid_article[:title],
          text: invalid_article[:text],
          user_id: invalid_article[:user_id],
          status: invalid_article[:status],
          language: invalid_article[:language],
          tags: invalid_article[:tags].pluck(:name).join(', ')
        }
      end
      it 'not changes Articles count' do
        expect { form.save }.not_to change(Article, :count)
      end

      it 'not changes ArticleTags count' do
        expect { form.save }.not_to change(ArticleTag, :count)
        expect(Article.last.tags.count).to eq(2)
      end

      it 'not updates the exist instance of Article with not correct values' do
        form.save
        updated_article = Article.last
        expect(updated_article.id).to eq(article.id)
        expect(updated_article.title).to eq(article.title)
        expect(updated_article.text).to eq(article.text)
        expect(updated_article.user_id).to eq(article.user_id)
        expect(updated_article.status).to eq(article.status)
        expect(updated_article.language).to eq(article.language)
        expect(updated_article.tags).to eq(article.tags)
      end

      it 'returns false' do
        expect(form.save).to eq(false)
      end
    end

    context 'when raises error' do
      before { allow(article).to receive(:update!).and_raise(ActiveRecord::RecordInvalid) }

      let(:article_params) do
        {
          title: invalid_article[:title],
          text: invalid_article[:text],
          user_id: invalid_article[:user_id],
          status: invalid_article[:status],
          language: invalid_article[:language],
          tags: invalid_article[:tags].pluck(:name).join(', ')
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
