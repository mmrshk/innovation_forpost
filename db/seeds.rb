# frozen_string_literal: true

require 'factory_bot_rails'

User.create!(
  email: 'admin@example.com',
  password: '123456',
  password_confirmation: '123456',
  phone_number: Faker::PhoneNumber.cell_phone,
  role: :super_admin
)

FactoryBot.create_list(:user, 50, :with_random_role)

FactoryBot.create_list(:article, 25, :with_random_user, :with_random_status, :with_random_language, :with_random_count_tags)

FactoryBot.create_list(:answer, 20)

FactoryBot.create_list(:company, 4, :with_random_language)

FactoryBot.create_list(:document, 3, :with_children)
FactoryBot.create_list(:document, 3, :with_children_and_their_children)