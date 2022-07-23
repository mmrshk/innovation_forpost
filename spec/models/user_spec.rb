# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:phone_number).of_type(:string) }
    it { is_expected.to have_db_column(:role).of_type(:integer).with_options(default: :user) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(default: '', null: false) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(precision: 6, null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(precision: 6, null: false) }
    it { is_expected.to have_db_index(:email).unique(true) }
    it 'creates valid user' do
      expect(create(:user)).to be_valid
      expect { create(:user) }.to change(User, :count).by(1)
    end
    it 'does not creates invalid user' do
      expect(build(:user, :invalid_params)).not_to be_valid
      # expect { create(:user, :invalid_params) }.to change(User, :count).by(0)
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:articles).dependent(:destroy).inverse_of(:user).with_foreign_key(:user_id) }
  end

  describe 'enum associations' do
    # it { should define_enum_for(:role).with_values(user: 0, admin: 1,super_admin: 2) }
    # it { should define_enum_for(:role).with_values(User::USER_ROLES) }
  end
end
