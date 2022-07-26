# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Updating an attachment', type: :feature do
  let!(:attachment) { create(:attachment) }
  
  scenario 'with valid name' do
    visit admins_attachments_path
    click_on I18n.t('admin.attachments.edit_link')
    fill_in I18n.t('admin.attachments.name'), with: 'NewName'
    click_on I18n.t('admin.attachments.save_button')
    expect(page).to have_content('NewName')
  end
end
