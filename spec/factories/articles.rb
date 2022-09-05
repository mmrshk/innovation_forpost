# frozen_string_literal: true

FactoryBot.automatically_define_enum_traits = false

FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: 5) }
    text { Faker::Lorem.paragraphs(number: 10).join }
    user_id { (create :user, %i[super_admin admin].sample).id }

    traits_for_enum(:status, %w[draft published trashed])
    traits_for_enum(:language, %w[uk en])

    trait :invalid_article do
      title { Faker::Lorem.characters(number: 101) }
      text { '' }
      user_id { nil }
      status { nil }
      language { nil }
    end

    trait :with_tags do
      transient do
        tags_count { 2 }
      end

      after(:create) do |article, evaluator|
        evaluator.tags_count.times { create(:article_tag, tag_id: create(:tag).id, article_id: article.id) }
      end
    end

    trait :with_random_count_tags do
      transient do
        tags_count { rand(0..3) }
      end

      after(:create) do |article, evaluator|
        evaluator.tags_count.times { create(:article_tag, tag_id: create(:tag).id, article_id: article.id) }
      end
    end

    trait :with_image do
      after(:create) do |article|
        create(:ck_editor_image, article_id: article.id)
      end
    end

    trait :with_image_url_inside_text do
      text { 
        Faker::Lorem.sentence(word_count: 5) +
        '</p><figure class="image"><img src="/uploads/ck_editor_image/file/1/clk1.jpeg"></figure><p>' +
        Faker::Lorem.paragraphs(number: 10).join
       }
    end

    trait :with_random_user do
      user_id { User.only_admins.sample.id }
    end

    trait :with_random_status do
      status { Article.statuses.values.sample }
    end

    trait :with_random_language do
      language { Article.languages.values.sample }
    end
  end
end
