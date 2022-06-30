class Article < ApplicationRecord
  include PGEnum(status: %w[draft published trashed])
  include PGEnum(language: %w[ukr eng])

  has_many    :taggings, dependent: :destroy
  has_many    :tags, through: :taggings
  belongs_to  :user

  default_scope -> { order(created_at: :desc) }

  validates   :title, presence: true, length: { maximum: 50 }
  validates   :text, presence: true
  validates   :user, presence: true
  validates   :status, presence: true
  validates   :language, presence: true
end
