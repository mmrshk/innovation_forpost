# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlePolicy, type: :policy do
  let!(:article) { create(:article) }

  subject { described_class.new(user, article) }

  context 'being a visitor' do
    let(:user) { nil }
    it { is_expected.to permit_action(:show) }
  end

  context 'being a super admin or admin' do
    let(:user) { create(:user, :super_admin, :admin) }
    it { is_expected.to permit_actions(%i[create update destroy]) }
  end
end
