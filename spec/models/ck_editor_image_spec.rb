# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CkEditorImage, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:file) }

    context 'uploads valid image' do
      let(:valid_image) { create(:ck_editor_image) }

      it { expect(valid_image).to be_valid }
      it { expect { valid_image }.to change(CkEditorImage, :count).by(1) }
    end

    context 'does not upload invalid image' do
      let(:invalid_image) { build(:ck_editor_image, :invalid_ck_editor_image) }

      it { expect(invalid_image).not_to be_valid }
      it { expect { invalid_image.save }.not_to change(CkEditorImage, :count) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:article).optional }
  end
end
