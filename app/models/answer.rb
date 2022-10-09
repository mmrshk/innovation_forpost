# frozen_string_literal: true

class Answer < ApplicationRecord
  LANGUAGES = {
    uk: 0,
    en: 1
  }.freeze

  enum language: LANGUAGES

  belongs_to :question

  validates :body, presence: true, length: { minimum: 2, maximum: 1000 }
end
