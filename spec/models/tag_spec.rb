require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'returns name' do
    tag = Tag.create(
      name: 'Tag'
    )
    expect(tag.name).to eq('Tag')
  end
end
