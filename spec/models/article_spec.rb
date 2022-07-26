# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:language) }
    it { is_expected.to define_enum_for(:language).with_values(%w[uk en]) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to define_enum_for(:status).with_values(%w[draft published trashed]) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to have_many(:article_tags).dependent(:destroy) }
    it { is_expected.to have_many(:tags).through(:article_tags) }
  end
end
