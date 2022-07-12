
require 'rails_helper'

RSpec.describe Articles::CreateForm do
  subject { described_class.new(current_user: current_user, params: acticle_params) }

  let(:current_user) { create(:user) }
  let(:acticle_params) { attributes_for(:article, user_id: current_user.id) }

  describe '#save' do
    context 'when success' do
      it 'creates article' do
        expect { subject.save }.to change(Article, :count).by(1)
      end

      it 'creates article_tags'
      it 'sets correct values to article'
    end

    context 'when failed'
  end
end