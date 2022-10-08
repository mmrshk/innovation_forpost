# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    let(:document) { create(:document, :with_children) }

    it { expect(document.children.count).to eql(2) }
  end
end
😄