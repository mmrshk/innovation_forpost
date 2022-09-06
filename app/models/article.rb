# frozen_string_literal: true

class Article < ApplicationRecord
  VALID_STATUSES = {
    draft: 0,
    published: 1,
    trashed: 2
  }.freeze

  LANGUAGES = {
    uk: 0,
    en: 1
  }.freeze

  enum status:   VALID_STATUSES
  enum language: LANGUAGES

  belongs_to  :user, foreign_key: 'user_id', inverse_of: :articles
  has_many    :article_tags, dependent: :destroy
  has_many    :tags, through: :article_tags
  has_many    :ck_editor_images, dependent: :destroy

  validates   :title, :text, :user, :status, :language, presence: true
  validates   :title, length: { maximum: 100 }

  scope :sorted_desc, -> { order(created_at: :desc) }
  scope :not_trashed, -> { where.not(status: VALID_STATUSES[:trashed]) }
  scope :in_language, ->(language) { where(language: language) }
end
