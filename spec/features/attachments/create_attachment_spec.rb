# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Creating an attachment', type: :feature do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  scenario 'with valid inputs' do
    visit new_admins_attachment_path
    fill_in I18n.t('admins.attachments.name'), with: 'IndustrialPark'
    attach_file(I18n.t('admins.attachments.choose_file'), "#{Rails.root}/spec/files/f.jpg")
    click_on I18n.t('admins.attachments.save_button')
    visit admins_attachments_path
    expect(page).to have_content('IndustrialPark')
  end

  scenario 'with invalid name input' do
    visit new_admins_attachment_path
    fill_in I18n.t('admins.attachments.name'), with: ''
    click_on I18n.t('admins.attachments.save_button')
    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'with invalid attachment input' do
    visit new_admins_attachment_path
    click_on I18n.t('admins.attachments.save_button')
    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end

  scenario 'choose view-link' do
    attachment = create(:attachment)
    visit admins_attachments_path
    click_on I18n.t('admins.attachments.view_link')
    expect(page).to have_content(attachment.name)
    expect(page).to have_content(attachment.id)
  end
end
