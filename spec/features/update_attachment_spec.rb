require 'rails_helper'

RSpec.describe 'Updating an attachment', type: :feature do
  scenario 'with valid name' do
    attachment = create(:attachment)
    visit admins_attachments_path
    click_on 'Edit'
    fill_in I18n.t('admin.attachments.name'), with: 'NewName'
    click_on 'Save'
    expect(page).to have_content('NewName')
  end
end