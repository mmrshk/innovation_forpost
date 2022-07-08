# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_presence_of(:text) }
end
