# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:articles).dependent(:destroy).inverse_of(:user) }
  end

  describe 'enum associations' do
    it { should define_enum_for(:role).with([0, 1, 2]) }
  end
end
