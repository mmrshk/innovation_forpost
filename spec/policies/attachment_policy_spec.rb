# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttachmentPolicy, type: :policy do
  let!(:attachment) { create(:attachment) }
  let!(:user) { create(:user) }

  subject { described_class }

  permissions :create? do
    context 'for user not in admin groups' do
      it { expect(subject).not_to permit(user) }
    end
  end

  permissions :update? do
    context 'for user not in admin groups' do
      it { expect(subject).not_to permit(user) }
    end
  end

  permissions :destroy? do
    context 'for user not in admin groups' do
      it { expect(subject).not_to permit(user) }
    end
  end
end
