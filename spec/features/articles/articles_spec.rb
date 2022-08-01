# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :feature do
  let!(:article) { create(:article, :published, :uk, :with_tags) }

  context 'when user visits an articles' do
    it 'index page' do
      visit articles_path(locale: I18n.locale)
      expect(page).to have_current_path articles_path(locale: I18n.locale)
      expect(page).to have_content(article.title)
      expect(page).to have_content(article.tags.pluck(:name).first)
    end

    it 'show page' do
      visit articles_path(locale: I18n.locale)
      expect(page).to have_current_path articles_path(locale: I18n.locale)
      click_link article.title
      expect(page).to have_content(article.title)
      expect(page).to have_content(article.tags.pluck(:name).first)
      expect(page).to have_current_path article_path(article, locale: I18n.locale)
      click_link 'All articles'
      expect(page).to have_current_path articles_path(locale: I18n.locale)
    end
  end

  context 'when user visits a tags' do
    it 'index page' do
      visit tags_path(locale: I18n.locale)
      expect(page).to have_current_path tags_path(locale: I18n.locale)
      expect(page).to have_content(article.tags.pluck(:name).first)
    end

    it 'show page' do
      visit article_path(article, locale: I18n.locale)
      expect(page).to have_current_path article_path(article, locale: I18n.locale)
      click_link article.tags.pluck(:name).first
      expect(page).to have_content(article.tags.pluck(:name).first)
      expect(page).to have_current_path tag_path(article.tags.first, locale: I18n.locale)
      expect(page).to have_content(article.title)
      click_link 'All articles'
      expect(page).to have_current_path articles_path(locale: I18n.locale)
    end
  end
end
