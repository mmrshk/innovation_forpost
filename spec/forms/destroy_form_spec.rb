# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Articles::DestroyForm do
  subject(:form) { described_class.new(params: {}, article: article) }

  let(:tags_list) { create_list(:tag, 2) }
  let!(:article) { create(:article, :published, :uk, tags: tags_list) }

  describe '#destroy successful' do
    context 'when article with tags' do
      it 'changes Articles count' do
        expect { form.save }.to change(Article, :count).by(-1)
      end

      it 'changes ArticleTags count' do
        expect { form.save }.to change(ArticleTag, :count).by(-2)
      end

      it 'changes Tags count' do
        expect { form.save }.to change(Tag, :count).by(-2)
      end
    end

    context 'when article with tags and another article has those tags' do
      let!(:another_article) { create(:article, :published, :uk, tags: tags_list) }
      it 'changes Articles count' do
        expect { form.save }.to change(Article, :count).by(-1)
      end

      it 'changes ArticleTags count' do
        expect { form.save }.to change(ArticleTag, :count).by(-2)
      end

      it 'does not change Tags count' do
        expect { form.save }.to change(Tag, :count).by(0)
      end
    end

    context 'when article with image' do
      let!(:article) { create(:article, :published, :uk, :with_image) }
      it 'changes Articles count' do
        expect { form.save }.to change(Article, :count).by(-1)
      end

      it 'changes CkEditorImage count' do
        expect { form.save }.to change(CkEditorImage, :count).by(-1)
      end
    end
  end
end
