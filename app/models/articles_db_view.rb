# frozen_string_literal: true

class ArticlesDbView < ApplicationRecord
  self.primary_key = 'article_id'

  def readonly?
    true
  end
end
