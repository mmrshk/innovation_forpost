# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :feature do
  let(:admin) { create(:user, :super_admin) }
  let(:article) { create(:article, :published, :uk) }
  let(:valid_article) { attributes_for(:article, :published, :uk) }
  let(:invalid_article) { attributes_for(:article, :invalid_article) }

  before do
    sign_in admin
    visit admins_articles_url
  end

  context 'when creating an article' do
    it 'creates' do
      click_link 'New Article'
      expect(page).to have_current_path new_admins_article_path(locale: I18n.locale)
      fill_in 'Title', with: valid_article[:title]
      fill_in 'article[text]', with: valid_article[:text]
      select valid_article[:status], from: 'article_status'
      select valid_article[:language], from: 'article_language'
      expect { click_button 'Create article' }.to change { Article.count }.by(1)
      expect(page).to have_current_path admins_articles_path(locale: I18n.locale)
      expect(page).to have_content(valid_article[:title])
    end

    it 'does not create' do
      click_link 'New Article'
      expect(page).to have_current_path new_admins_article_path(locale: I18n.locale)
      fill_in 'Title', with: invalid_article[:title]
      fill_in 'article[text]', with: invalid_article[:text]
      expect { click_button 'Create article' }.to change { Article.count }.by(0)
      expect(page).to have_content('не може бути пустим')
    end
  end

  context 'when updating an article' do
    it 'updates' do
      visit edit_admins_article_path(article)
      expect(page).to have_current_path edit_admins_article_path(article)
      fill_in 'Title', with: valid_article[:title]
      fill_in 'article[text]', with: valid_article[:text]
      select valid_article[:status], from: 'article_status'
      select valid_article[:language], from: 'article_language'
      expect { click_button 'Update article' }.to change { Article.count }.by(0)
      expect(page).to have_content(valid_article[:title])
    end

    it 'does not update' do
      visit edit_admins_article_path(article)
      expect(page).to have_current_path edit_admins_article_path(article)
      fill_in 'Title', with: invalid_article[:title]
      fill_in 'article[text]', with: invalid_article[:text]
      expect { click_button 'Update article' }.to change { Article.count }.by(0)
      expect(page).to have_content('не може бути пустим')
    end
  end

  context 'when destroing an article' do
    let!(:article) { create(:article, :published, :uk) }

    it 'destroyes' do
      visit admins_articles_url
      expect(page).to have_content(article[:title])
      expect { find('tr', text: article.title).click_on('Delete') }.to change(Article, :count).by(-1)
      expect(page).not_to have_content(article[:title])
    end
  end
end
