# frozen_string_literal: true

class Article < ApplicationRecord
  include ArticleHelper

  enum status:   VALID_STATUSES, _prefix: true
  enum language: LANGUAGES, _prefix: true

  has_many    :article_tags
  has_many    :tags, through: :article_tags
  belongs_to  :user

  default_scope -> { order(created_at: :desc) }

  validates   :title, presence: true, length: { maximum: 50 }
  validates   :text, presence: true
  validates   :user, presence: true
  validates   :status, presence: true, inclusion: { in: VALID_STATUSES }
  validates   :language, presence: true, inclusion: { in: LANGUAGES }
end
