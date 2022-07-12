# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create(:article) }
  it { expected(article).to be_valid }
end
