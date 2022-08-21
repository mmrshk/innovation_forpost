require 'rails_helper'

RSpec.describe 'Filter users', type: :feature do
  let!(:user) { create(:user, :super_admin) }

  before do
    sign_in user
  end

  scenario 'with phone number' do
    visit admins_users_path
    click_on I18n.t('admins.users.filter')
    fill_in I18n.t('admins.users.phone'), with: user.phone_number
    click_on I18n.t('admins.users.search')
    expect(page).to have_content(user.phone_number)
  end

  scenario 'with email address' do
    visit admins_users_path
    click_on I18n.t('admins.users.filter')
    fill_in I18n.t('admins.users.email'), with: user.email
    click_on I18n.t('admins.users.search')
    expect(page).to have_content(user.email)
  end

  scenario 'view user profile' do
    visit admins_users_path
    click_on I18n.t('admin.attachments.view_link')
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.phone_number)
  end
end
