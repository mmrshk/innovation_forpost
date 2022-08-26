# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CkEditorImageService do
  subject(:service) { described_class.new(upload_params) }

  describe 'uploads image successful' do
    context 'when params are correct' do
      let(:upload_params) { attributes_for(:ck_editor_image_service) }

      it 'returns true' do
        expect(service.save).to eq(true)
      end

      it 'changes CkEditorImage count' do
        expect { service.save }.to change(CkEditorImage, :count).by(1)
      end

      it 'adds url to the uploaded image' do
        service.save
        expect(CkEditorImage.last.url).to eq(service.uploaded_image.url)
      end
    end
  end

  describe 'does not upload image successful' do
    context 'when params are incorrect' do
      let(:upload_params) { attributes_for(:ck_editor_image_service, :invalide_file) }

      it 'returns false' do
        expect(service.save).to eq(false)
      end

      it 'does not change CkEditorImage count' do
        expect { service.save }.not_to change(CkEditorImage, :count)
      end
    end
  end
end
