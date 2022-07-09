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

  # belongs_to  :user, foreign_key: 'user_id', inverse_of: :articles
  belongs_to  :user, inverse_of: :articles
  has_many    :article_tags, dependent: :destroy
  has_many    :tags, through: :article_tags

  validates   :title, :text, :user, :status, :language, presence: true
  validates   :title, length: { maximum: 50 }

  self.per_page = 10 # Default per_page for paginate

  # def tag_list
  #   tags.join(", ")
  # end

  # def tag_list=(tags_string); end

  def tag_list=(tags_string)
    tag_names = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  def tag_list_names
    tags.map { |tag| tag }.join(', ')
  end
end
