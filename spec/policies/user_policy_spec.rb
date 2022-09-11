# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do

  subject { described_class.new(user, user) }

  context 'being a super admin' do
    let(:user) { create(:user, :super_admin) }
    it { is_expected.to permit_actions([:update, :destroy]) }
  end

  context 'being a admin' do
    let(:user) { create(:user, :admin) }
    it { is_expected.to permit_actions([:create]) }
  end
end
