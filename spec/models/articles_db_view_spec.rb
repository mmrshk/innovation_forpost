# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesDbView, type: :model do
  describe 'ArticleDbView behaviour' do
    subject {described_class.all}
    
    let!(:article_work) {create(:article, :published, :with_tags, :user_example_id)}
    let!(:tag) { create(:tag, :work_tag) }
    let!(:article_tag) do
      { article_id: article_work.id,
        tag_id:     tag.id
      }
    end

    it 'should show articles with certain tags' do
      # raise [article_work, tag, article_tag].inspect
      binding.pry
      expect(subject.count).to eq(1)
    end
  end
end
