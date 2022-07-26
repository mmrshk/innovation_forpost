# frozen_string_literal: true

class ArticlePresenter
  def initialize(article)
    @article = article
  end

  # def css_color_article
  #   @article.draft? ? "red" : "black"
  # end

  def all_tags
    @article.tags.present? ? @article.tags.pluck(:name).join(', ') : ''
  end
end
