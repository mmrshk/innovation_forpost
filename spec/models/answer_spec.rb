# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(2).is_at_most(1000) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:question) }
  end
end
