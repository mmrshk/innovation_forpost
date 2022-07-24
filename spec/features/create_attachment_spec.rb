require 'rails_helper'

RSpec.describe 'Creating an attachment', type: :feature do
  scenario 'with valid inputs' do
    visit new_admin_attachment_path
    fill_in I18n.t('admin.attachments.name'), with: 'IndustrialPark'
    attach_file(I18n.t('admin.attachments.choose_file'), Rails.root + "spec/files/f.jpg")
    click_on 'Save'
    visit admin_attachments_path
    expect(page).to have_content('IndustrialPark')
  end

  scenario 'with invalid name input' do
    visit new_admin_attachment_path
    fill_in I18n.t('admin.attachments.name'), with: '' 
    click_on 'Save'
    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'with invalid attachment input' do
    visit new_admin_attachment_path
    click_on 'Save'
    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'choose view-link' do
    attachment = create(:attachment)
    visit admin_attachments_path
    click_on 'View'
    expect(page).to have_content(attachment.name)
    expect(page).to have_content(attachment.id)
  end
end