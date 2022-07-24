require 'rails_helper'

RSpec.describe 'Deleting an attachment', type: :feature do
  scenario 'delete an attachment' do
    attachment = create(:attachment)
    visit admins_attachments_path
    click_on 'Delete'
    expect(page).to_not have_content(attachment.name)
  end
end