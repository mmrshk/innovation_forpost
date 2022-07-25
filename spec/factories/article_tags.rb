# frozen_string_literal: true

FactoryBot.define do
  factory :article_tag do
    article_id { :article }
    tag_id { :tag }
  end
end
