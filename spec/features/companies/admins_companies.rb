# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company', type: :feature do
  let(:admin) { create(:user, :super_admin) }
  let(:company) { create(:company, :uk) }
  let(:valid_company) { attributes_for(:company, :en) }
  let(:invalid_company) { attributes_for(:company, :with_invalid_data) }

  before do
    sign_in admin
    visit admins_companies_url
  end

  context 'when creating a company with valid data' do
    it 'creates' do
      click_link I18n.t('admins.companies.views.buttons.new_company')
      expect(page).to have_current_path new_admins_company_path(locale: I18n.locale)
      fill_in I18n.t('admins.companies.views.labels.name'), with: valid_company[:name]
      fill_in I18n.t('admins.companies.views.labels.start_year'), with: valid_company[:start_year]
      fill_in I18n.t('admins.companies.views.labels.projects_count'), with: valid_company[:projects_count]
      fill_in I18n.t('admins.companies.views.labels.clients_count'), with: valid_company[:clients_count]
      fill_in I18n.t('admins.companies.views.labels.grants_count'), with: valid_company[:grants_count]
      fill_in I18n.t('admins.companies.views.labels.priority'), with: valid_company[:priority]
      select valid_company[:language], from: 'company_language'
      fill_in I18n.t('admins.companies.views.labels.text_about'), with: valid_company[:text_about]
      attach_file(I18n.t('admins.companies.views.buttons.upload_logo'), "#{Rails.root}/spec/files/f.jpg")
      expect { click_button I18n.t('admins.companies.views.buttons.create_company') }.to change { Company.count }.by(1)
      expect(page).to have_current_path admins_companies_path(locale: I18n.locale)
      expect(page).to have_content(valid_company[:name])
      expect(page).to have_content(valid_company[:start_year])
      expect(page).to have_content(valid_company[:projects_count])
      expect(page).to have_content(valid_company[:clients_count])
      expect(page).to have_content(valid_company[:grants_count])
      expect(page).to have_content(valid_company[:priority])
      expect(page).to have_content(valid_company[:language])
      expect(page).to have_content(valid_company[:text_about])
      expect(page).to have_content(I18n.t('admins.companies.views.hints.logo_present'))
    end

    it 'does not create with invalid data' do
      click_link I18n.t('admins.companies.views.buttons.new_company')
      expect(page).to have_current_path new_admins_company_path(locale: I18n.locale)
      fill_in I18n.t('admins.companies.views.labels.name'), with: invalid_company[:name]
      fill_in I18n.t('admins.companies.views.labels.start_year'), with: invalid_company[:start_year]
      fill_in I18n.t('admins.companies.views.labels.projects_count'), with: invalid_company[:projects_count]
      fill_in I18n.t('admins.companies.views.labels.clients_count'), with: invalid_company[:clients_count]
      fill_in I18n.t('admins.companies.views.labels.grants_count'), with: invalid_company[:grants_count]
      fill_in I18n.t('admins.companies.views.labels.priority'), with: invalid_company[:priority]
      fill_in I18n.t('admins.companies.views.labels.text_about'), with: invalid_company[:text_about]
      attach_file(I18n.t('admins.companies.views.buttons.upload_logo'), "#{Rails.root}/spec/files/image")
      expect { click_button I18n.t('admins.companies.views.buttons.create_company') }.not_to(change { Company.count })
    end

    it 'does not create with incomplete data' do
      click_link I18n.t('admins.companies.views.buttons.new_company')
      expect(page).to have_current_path new_admins_company_path(locale: I18n.locale)
      fill_in I18n.t('admins.companies.views.labels.name'), with: invalid_company[:name]
      fill_in I18n.t('admins.companies.views.labels.start_year'), with: invalid_company[:start_year]
      fill_in I18n.t('admins.companies.views.labels.projects_count'), with: invalid_company[:projects_count]
      fill_in I18n.t('admins.companies.views.labels.clients_count'), with: invalid_company[:clients_count]
      fill_in I18n.t('admins.companies.views.labels.grants_count'), with: invalid_company[:grants_count]
      expect { click_button I18n.t('admins.companies.views.buttons.create_company') }.not_to(change { Company.count })
      expect(page).to have_content('не може бути пустим')
    end
  end

  context 'when updating a company with valid data' do
    it 'updates' do
      visit edit_admins_company_path(company)
      expect(page).to have_current_path edit_admins_company_path(company)
      fill_in I18n.t('admins.companies.views.labels.name'), with: valid_company[:name]
      fill_in I18n.t('admins.companies.views.labels.start_year'), with: valid_company[:start_year]
      fill_in I18n.t('admins.companies.views.labels.projects_count'), with: valid_company[:projects_count]
      fill_in I18n.t('admins.companies.views.labels.clients_count'), with: valid_company[:clients_count]
      fill_in I18n.t('admins.companies.views.labels.grants_count'), with: valid_company[:grants_count]
      fill_in I18n.t('admins.companies.views.labels.priority'), with: valid_company[:priority]
      select valid_company[:language], from: 'company_language'
      fill_in I18n.t('admins.companies.views.labels.text_about'), with: valid_company[:text_about]
      attach_file(I18n.t('admins.companies.views.buttons.upload_logo'), "#{Rails.root}/spec/files/pr.jpg")
      expect { click_button I18n.t('admins.companies.views.buttons.update_company') }.not_to(change { Company.count })
      expect(page).to have_current_path admins_companies_path(locale: I18n.locale)
      expect(page).to have_content(valid_company[:name])
      expect(page).to have_content(valid_company[:start_year])
      expect(page).to have_content(valid_company[:projects_count])
      expect(page).to have_content(valid_company[:clients_count])
      expect(page).to have_content(valid_company[:grants_count])
      expect(page).to have_content(valid_company[:priority])
      expect(page).to have_content(valid_company[:language])
      expect(page).to have_content(valid_company[:text_about])
      expect(page).to have_content(I18n.t('admins.companies.views.hints.logo_present'))
    end

    it 'does not update with invalid data' do
      visit edit_admins_company_path(company)
      expect(page).to have_current_path edit_admins_company_path(company)
      fill_in I18n.t('admins.companies.views.labels.name'), with: invalid_company[:name]
      fill_in I18n.t('admins.companies.views.labels.start_year'), with: invalid_company[:start_year]
      fill_in I18n.t('admins.companies.views.labels.projects_count'), with: invalid_company[:projects_count]
      fill_in I18n.t('admins.companies.views.labels.clients_count'), with: invalid_company[:clients_count]
      fill_in I18n.t('admins.companies.views.labels.grants_count'), with: invalid_company[:grants_count]
      fill_in I18n.t('admins.companies.views.labels.priority'), with: invalid_company[:priority]
      select invalid_company[:language], from: 'company_language'
      fill_in I18n.t('admins.companies.views.labels.text_about'), with: invalid_company[:text_about]
      attach_file(I18n.t('admins.companies.views.buttons.upload_logo'), "#{Rails.root}/spec/files/image")
      expect { click_button I18n.t('admins.companies.views.buttons.update_company') }.not_to(change { Company.count })
      expect(page).to have_content('має бути більше ніж 0')
    end
  end

  context 'when destroing a company' do
    let!(:company) { create(:company) }

    it 'destroyes' do
      visit admins_companies_url
      expect(page).to have_content(company[:name])

      expected = expect do
        find('.row-table-company', text: company.name).click_on(I18n.t('admins.companies.views.buttons.delete'))
      end

      expected.to change(Company, :count).by(-1)
      expect(page).not_to have_content(company[:name])
    end
  end
end
