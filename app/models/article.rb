# frozen_string_literal: true

class Article < ApplicationRecord  
  include PgSearch::Model

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
  pg_search_scope :articles_search,
                  against:  {
                    title: 'A',
                    text: 'B'
                  },
                  associated_against: {
                    tags: { 
                      name: 'B'
                    }   
                  },
                  using: {
                    tsearch: {
                      prefix: true,
                      dictionary: "english",
                    }
                  }
end                
