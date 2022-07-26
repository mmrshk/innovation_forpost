# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attachment, type: :request do
  let!(:attachment) { create(:attachment) }

  describe 'GET/index' do
    it 'successful response' do
      get admins_attachments_path
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'successful read' do
      get new_admins_attachment_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'successful response' do
      get edit_admins_attachment_path(attachment)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:params) { attributes_for(:attachment) }

    it 'create attachment with valid params' do
      post admins_attachments_path, params: { attachment: params }
      expect(response).to redirect_to admins_attachments_path(locale: I18n.locale)
    end
  end

  describe 'PATCH /update' do
    let(:params) { attributes_for(:attachment) }

    it 'update attachment with valid params' do
      patch admins_attachment_path(attachment), params: { attachment: params }
      expect(Attachment.find(attachment.id).name).to eq params[:name]
      expect(response).to redirect_to admins_attachment_path(attachment, locale: I18n.locale)
    end
  end

  describe 'DELETE /destroy' do
    let(:params) { attributes_for(:attachment) }

    it 'delete attachment' do
      delete admins_attachment_path(attachment), params: { attachment: params }
      expect(response).to redirect_to admins_attachments_path(locale: I18n.locale)
    end
  end
end
