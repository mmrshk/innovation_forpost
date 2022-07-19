# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    let(:document) { create(:document, :with_children) }

    it 'should have two children' do
      expect(document.children.count).to eql(2)
    end
  end
end
