# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Updating an attachment', type: :feature do
  let!(:attachment) { create(:attachment) }
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  scenario 'with valid name' do
    visit admins_attachments_path
    click_on I18n.t('admins.attachments.edit_link')
    fill_in I18n.t('admins.attachments.name'), with: 'NewName'
    click_on I18n.t('admins.attachments.save_button')
    expect(page).to have_content('NewName')
  end
end
