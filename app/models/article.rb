class Article < ApplicationRecord
  # enum article_status: {
  #   draft: "draft",
  #   published: "published",
  #   trashed: "trashed"
  # }, prefix: :articles
  include PGEnum(status: %w[draft published trashed])

  has_many    :taggings, dependent: :destroy
  has_many    :tags, through: :taggings
  belongs_to  :user

  default_scope -> { order(created_at: :desc) }

  validates   :title, presence: true, length: { maximum: 50 }
  validates   :text, presence: true
  validates   :user, presence: true
  validates   :status, presence: true
end
