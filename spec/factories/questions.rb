# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { 'MyString' }
    user_name { 'MyString' }
    user_email { 'MyString' }
    body { 'MyText' }
  end
end
