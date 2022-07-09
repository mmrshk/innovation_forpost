# frozen_string_literal: true

class Tag < ApplicationRecord
  TAGNAME_LENGTH_MAX = 2

  has_many  :article_tags, dependent: :destroy
  has_many  :articles, through: :article_tags

  validates :name, presence: true, length: { minimum: TAGNAME_LENGTH_MAX }, uniqueness: true

  def to_s
    name
  end
end
