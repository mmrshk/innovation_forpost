# frozen_string_literal: true

class ArticleTag < ApplicationRecord
  belongs_to :tag
  belongs_to :article
end
