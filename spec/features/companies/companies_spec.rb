# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company', type: :feature do
  let(:admin) { create(:user, :super_admin) }
  let!(:company) { create(:company, :uk) }
  let!(:news_list) { create_list(:article, 9, :published, :uk) }
  let!(:docs_list) { create_list(:attachment, 12) }

  before do
    visit companies_path(locale: I18n.locale)
  end

  context 'when user visits company page' do
    it 'index page - shows company part' do
      expect(page).to have_current_path companies_path(locale: I18n.locale)
      expect(page).to have_content(Date.today.year - company.start_year)
      expect(page).to have_content(company.projects_count)
      expect(page).to have_content(company.clients_count)
      expect(page).to have_content(company.grants_count)
      expect(page).to have_content(company.text_about)
    end

    it 'index page - shows news part' do
      expect(page).to have_current_path companies_path(locale: I18n.locale)
      news_list.each do |news|
        expect(page).to have_content(news.title)
      end
    end

    it 'index page - shows news cards' do
      expect(page).to have_current_path companies_path(locale: I18n.locale)
      expect(page).to have_selector('.news-block', count: 9)
    end

    it 'index page - shows documents part' do
      expect(page).to have_current_path companies_path(locale: I18n.locale)
      docs_list.each do |doc|
        expect(page).to have_content(doc.name)
      end
    end

    it 'index page - shows documents cards' do
      expect(page).to have_current_path companies_path(locale: I18n.locale)
      expect(page).to have_selector('.docs-block', count: 12)
    end
  end

  context 'when user click on news card' do
    it 'open news page' do
      expect(page).to have_current_path companies_path(locale: I18n.locale)
      find('.news-title', text: news_list.first.title).click
      expect(page).to have_current_path article_path(news_list.first, locale: I18n.locale)
      expect(page).to have_content(news_list.first.title)
    end
  end
end
