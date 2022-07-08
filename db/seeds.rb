# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users_role = %w[admin superadmin]

5.times do
  password = Faker::Internet.password(min_length: 8, max_length: 20, mix_case: true, special_characters: true)
  User.create!(
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    role: users_role.sample,
    phone_number: Faker::PhoneNumber.cell_phone
  )
end

25.times do
  Article.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    user_id: User.all.sample.id,
    text: Faker::Lorem.paragraphs(number: 3),
    language: Article.languages[Article.languages.keys.sample],
    status: Article.statuses[Article.statuses.keys.sample]
  )
end

10.times do
  Tag.create!(
    name: Faker::Lorem.word
  )
end

Tag.all.each do |tag|
  rand(1..3).times do
    ArticleTag.create!(
      tag_id: tag.id,
      article_id: Article.all.sample.id
    )
  end
end
