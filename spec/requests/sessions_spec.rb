# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions' do
  it 'signs user in and out' do
    user = create(:user, :admin)
    sign_in user
    get admins_articles_url
    expect(response).to render_template(:index)

    sign_out user
    get admins_articles_url
    expect(response).not_to render_template(:index)
  end
end
