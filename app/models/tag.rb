# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many  :article_tags
  has_many  :articles, through: :article_tags
  validates :name, presence: true, length: { minimum: 2 }
end
