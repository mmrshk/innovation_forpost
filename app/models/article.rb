# frozen_string_literal: true

class Article < ApplicationRecord
  # this is required for the following function
  scope :sorted, -> { order(created_at: :desc) }

  VALID_STATUSES = {
    draft: 0,
    published: 1,
    trashed: 2
  }.freeze

  LANGUAGES = {
    ua: 0,
    en: 1
  }.freeze

  enum status:   VALID_STATUSES
  enum language: LANGUAGES

  belongs_to  :user
  has_many    :article_tags, dependent: :destroy
  has_many    :tags, through: :article_tags, dependent: :nullify

  validates   :title, :text, :user, :status, :language, presence: true
  validates   :title, length: { maximum: 50 }

  self.per_page = 10 # Default per_page for paginate
end
