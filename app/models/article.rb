class Article < ApplicationRecord
  enum status: {
    draft: "draft",
    published: "published",
    trashed: "trashed"
  }
  include PGEnum(status: %w[draft published trashed])

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_one  :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :text, presence: true
  validates :autor, presence: true
  validates :status, presence: true

end
