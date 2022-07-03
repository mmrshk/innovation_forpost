# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'returns title' do
    article = Article.create(
      title: 'First Article',
      text: 'Some text for First Article',
      user_id: 1,
      status: 'published',
      language: 'eng'
    )
    expect(article.title).to eq('First Article')
  end

  it 'returns text' do
    article = Article.create(
      title: 'First Article',
      text: 'Some text for First Article',
      user_id: 1,
      status: 'published',
      language: 'eng'
    )
    expect(article.text).to eq('Some text for First Article')
  end

  it 'returns status' do
    article = Article.create(
      title: 'First Article',
      text: 'Some text for First Article',
      user_id: 1,
      status: 'published',
      language: 'eng'
    )
    expect(article.status).to eq('published')
  end

  it 'returns language' do
    article = Article.create(
      title: 'First Article',
      text: 'Some text for First Article',
      user_id: 1,
      status: 'published',
      language: 'eng'
    )
    expect(article.language).to eq('eng')
  end
end
