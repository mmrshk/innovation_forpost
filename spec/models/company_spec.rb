# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_year) }
    it { should validate_numericality_of(:start_year).only_integer }
    it { should validate_numericality_of(:start_year).is_less_than_or_equal_to(Date.today.year) }
    it { should validate_numericality_of(:start_year).is_greater_than(0) }
    it { should_not allow_value(-1).for(:start_year) }
    it { should_not allow_value(Date.today.year + 1).for(:start_year) }
    it { should allow_value(2010).for(:start_year) }
    it { should validate_presence_of(:projects_count) }
    it { should validate_numericality_of(:projects_count).only_integer }
    it { should validate_numericality_of(:projects_count).is_greater_than(0) }
    it { should_not allow_value(0.5).for(:projects_count) }
    it { should_not allow_value(-1).for(:projects_count) }
    it { should allow_value(100).for(:projects_count) }
    it { should allow_value(0).for(:projects_count) }
    it { should validate_presence_of(:clients_count) }
    it { should validate_numericality_of(:clients_count).only_integer }
    it { should validate_numericality_of(:clients_count).is_greater_than(0) }
    it { should_not allow_value(0.5).for(:clients_count) }
    it { should_not allow_value(-1).for(:clients_count) }
    it { should allow_value(100).for(:clients_count) }
    it { should validate_presence_of(:grants_count) }
    it { should validate_numericality_of(:grants_count).only_integer }
    it { should validate_numericality_of(:grants_count).is_greater_than(0) }
    it { should_not allow_value(0.5).for(:grants_count) }
    it { should_not allow_value(-1).for(:grants_count) }
    it { should allow_value(100).for(:grants_count) }
    it { should validate_presence_of(:text_about) }
    it { should validate_length_of(:text_about).is_at_least(20) }
    it { should validate_length_of(:text_about).is_at_most(1000) }
    it { should validate_presence_of(:logo) }
    it { should validate_presence_of(:media_file) }
  end

  describe 'creates successful' do
    context 'when params are correct' do
      it 'has none to begin with' do
        expect(Company.count).to eq 0
      end

      it 'changes Company count' do
        expect(create(:company)).to be_valid
        expect { create(:company) }.to change(Company, :count).by(1)
      end

      it 'has none after one was created in a previous example' do
        expect(Company.count).to eq 0
      end
    end
  end

  describe 'creates unsuccessful' do
    context 'when params are invalid' do
      let(:invalid_company) { build(:company, :with_invalid_data) }

      it 'has none to begin with' do
        expect(Company.count).to eq 0
      end

      it 'not changes Company count' do
        expect(invalid_company).not_to be_valid
        expect { invalid_company.save }.not_to change(Company, :count)
      end

      it 'has none after one was created in a previous example' do
        expect(Company.count).to eq 0
      end
    end
  end
end
