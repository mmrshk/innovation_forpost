# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'is valid with a name' do
    document = Document.new(
      name: 'Test document'
    )
    expect(document).to be_valid
  end
end
