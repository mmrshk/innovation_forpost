# frozen_string_literal: true

class Company < ApplicationRecord
  LANGUAGES = {
    uk: 0,
    en: 1
  }.freeze

  enum language: LANGUAGES

  has_one_attached :media_file

  validates :name,
            :start_year,
            :projects_count,
            :clients_count,
            :grants_count,
            :text_about,
            :language, presence: true
  validates :start_year, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: Date.today.year }
  validates :projects_count,
            :clients_count,
            :grants_count, numericality: { only_integer: true, greater_than: 0 }
  validates :text_about, length: { in: 20..1000 }
  validates :media_file, attached: true, content_type: %i[png jpg jpeg],
                         size: { less_than: 5.megabytes, message: 'is too large' }

  scope :in_language, ->(language) { where(language: language) }
end
