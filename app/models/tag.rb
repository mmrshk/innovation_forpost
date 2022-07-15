# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many  :article_tags, dependent: :destroy
  has_many  :articles, through: :article_tags

  validates :name, presence: true,
                   length: { minimum: 2, maximum: 20 },
                   allow_blank: false,
                   allow_nil: false,
                   uniqueness: { case_sensitive: false }
end
