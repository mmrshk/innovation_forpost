# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(2).is_at_most(255) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(2).is_at_most(1000) }
    it { is_expected.to validate_presence_of(:user_name) }
    it { is_expected.to validate_length_of(:user_name).is_at_least(2).is_at_most(255) }
    it { is_expected.to validate_length_of(:user_email).is_at_most(255) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:answers).dependent(:destroy) }
  end
end
