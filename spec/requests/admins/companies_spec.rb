# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let(:admin) { create(:user, :super_admin) }

  before do
    sign_in admin
  end

  describe 'GET /admins/companies#index' do
    it 'renders a successful response' do
      get admins_companies_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /admins/companies#new' do
    it 'renders a successful response' do
      get new_admins_company_url
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /admins/companies#create' do
    context 'with valid parameters' do
      let(:valid_company) { attributes_for(:company) }

      it 'creates a new company' do
        post admins_companies_url, params: { company: valid_company }
        expect(response).to have_http_status(:redirect)
        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(response.body).to include(I18n.t('admins.companies.create_success'))
      end

      it 'creates a new instance of Company with correct values' do
        expect { post admins_companies_url, params: { company: valid_company } }.to change(Company, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_company) { build(:company, :with_invalid_data) }
      let(:invalid_params) { attributes_for(:company, :with_invalid_data) }

      it 'does not create a new company' do
        expect { post admins_companies_url, params: { company: invalid_params } }.not_to change(Company, :count)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        get new_admins_company_url
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
        post admins_companies_url, params: { company: invalid_params }
        expect(invalid_company).not_to be_valid
        expect(response).to have_http_status(422)
        expect(response).to render_template(:new)
        expect(response.body).to include(I18n.t('admins.companies.create_unsuccess'))
      end
    end
  end

  describe 'GET /admins/companies#edit' do
    let(:valid_company) { create(:company) }

    it 'render a successful response' do
      get edit_admins_company_url(valid_company)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let!(:valid_company) { create(:company) }
      let(:valid_params) do
        {
          name: Faker::Company.name,
          start_year: 2010,
          projects_count: rand(1..100),
          clients_count: rand(1..100),
          grants_count: rand(1..100),
          text_about: Faker::Lorem.characters(number: 100),
          logo: Faker::File.file_name.split('/').last[0..15],
          media_file: Rack::Test::UploadedFile.new('spec/files/f.jpg', 'image/jpg')
        }
      end

      it 'updates the requested company' do
        get edit_admins_company_url(valid_company)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
        patch admins_company_url(valid_company), params: { company: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admins_companies_url(locale: I18n.locale))
        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(response.body).to include(I18n.t('admins.companies.update_success'))
      end
    end

    context 'with invalid parameters' do
      let!(:valid_company) { create(:company) }
      let(:invalid_params) { attributes_for(:company, :with_invalid_data) }

      it "renders a successful response (i.e. to display the 'edit' template)" do
        get edit_admins_company_url(valid_company)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
        patch admins_company_url(valid_company), params: { company: invalid_params }
        expect(response).to have_http_status(422)
        expect(response).to render_template(:edit)
        expect(response.body).to include(I18n.t('admins.companies.update_unsuccess'))
      end
    end
  end

  describe 'DELETE /admins/companies#destroy' do
    let!(:valid_company) { create(:company) }

    it 'destroys the requested company' do
      expect { delete admins_company_url(valid_company) }.to change(Company, :count).by(-1)
    end

    it 'redirects to the companies list' do
      delete admins_company_url(valid_company)
      expect(response).to redirect_to(admins_companies_url(locale: I18n.locale))
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include(I18n.t('admins.companies.destroy_success'))
    end

    context 'failing the destroy function' do
      let(:valid_company) { build_stubbed(:company) }

      before do
        allow(valid_company).to receive(:destroy).and_return(false)
        allow(Company).to receive(:find).and_return(valid_company)
      end

      it 'renders delete' do
        delete admins_company_url(valid_company)
        expect(response).to have_http_status(:no_content)
        expect(response).to render_template(:index)
      end
    end
  end
end
