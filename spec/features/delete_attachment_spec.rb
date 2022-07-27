# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Deleting an attachment', type: :feature do
  let!(:attachment) { create(:attachment) }

  scenario 'delete an attachment' do
    visit admins_attachments_path
    click_on I18n.t('admin.attachments.delete_link')
    expect(page).to_not have_content(attachment.name)
  end
end
