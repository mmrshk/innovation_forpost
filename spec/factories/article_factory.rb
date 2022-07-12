# frozen_string_literal: true

FactoryBot.define do
  # factory :article do
  #   transient do
  #     with_article_tags { true }
  #     article_tags_count { 2 }
  #   end
  factory :article do
    user

    title { Faker::Lorem.sentence(word_count: 3) }
    text { Faker::Lorem.paragraphs(number: 3) }
    language { Article.languages[Article.languages.keys.sample] }
    status { Article.statuses[Article.statuses.keys.sample] }
  end

  #   content { FFaker::Lorem.paragraph }

  #   after(:create) do |article, evaluator|
  #     if evaluator.with_article_tags
  #       evaluator.article_tags_count.times { create(:article_tag, tag_id: create(:tag).id, article_id: article.id) }
  #     end
  #   end

  #   trait :dratf do
  #     status { 'draft' }
  #   end

  #   trait :published do
  #     status { 'published' }
  #   end

  #   trait :trashed do
  #     status { 'trashed' }
  #   end
  # end
end
