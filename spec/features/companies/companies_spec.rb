# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company', type: :feature do
  let(:admin) { create(:user, :super_admin) }
  let!(:company_list) { create_list(:company, 2) }
  let!(:news_list) { create_list(:article, 9, :published, :uk) }
  let!(:docs_list) { create_list(:attachment, 12) }

  before do
    visit companies_path(locale: I18n.locale)
  end

  context 'when user visits company page' do
    it 'index page - shows company part' do
      expect(page).to have_current_path companies_path(locale: I18n.locale)
      company_list.each do |company|
        expect(page).to have_content(company.name)
        expect(page).to have_content(Date.today.year - company.start_year)
        expect(page).to have_content(company.projects_count)
        expect(page).to have_content(company.clients_count)
        expect(page).to have_content(company.grants_count)
        expect(page).to have_content(company.text_about)
      end
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

  context 'when user click on doc card' do
    it 'open news page' do
      # Will be changed to attachment_path for the client side after merging the corresponding pull request
      sign_in admin
      expect(page).to have_current_path companies_path(locale: I18n.locale)
      find('a', text: docs_list.first.name).click
      expect(page).to have_current_path admins_attachment_path(docs_list.first, locale: I18n.locale)
      expect(page).to have_content(docs_list.first.name)
    end
  end

  context 'when showing by priority' do
    it 'shows by prioryty' do
      expect(page).to have_current_path companies_path(locale: I18n.locale)
      actual_company_list = []
      company_list.each do |company|
        actual_company_list << find('.company-name', text: company.name).text
      end
      expect(actual_company_list).to eq(company_list.pluck(:name))
    end
  end
end
