# frozen_string_literal: true

class ArticlePresenter
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
  include ActionView::Context

  TAG_FIGURE_REGEX = /<figure[^>]/
  TEXT_WITH_FIGURE_REGEX = %r{[\s\S]*?</figure>}
  LENGTH_TRUNCATE_DEFAULT = 500
  LENGTH_ADJUSTMENT_TRUNCATE = 0

  def initialize(article)
    @article = article
  end

  def all_tags
    @article.tags.present? ? @article.tags.pluck(:name).join(', ') : ''
  end

  def truncate_article_text
    truncate(@article.text.to_s, escape: false, length: length_truncate, omission: '') do
      link_to '...Continue', controller: 'articles', action: 'show', id: @article.id
    end
  end

  private

  def length_truncate
    truncate_text = truncate(@article.text.to_s, length: LENGTH_TRUNCATE_DEFAULT, escape: false)
    check_figure_present(truncate_text)
  end

  def check_figure_present(text)
    text.match(TAG_FIGURE_REGEX) ? check_length(text) : LENGTH_TRUNCATE_DEFAULT
  end

  def check_length(text)
    length_figure = text.match(TEXT_WITH_FIGURE_REGEX).to_s.length + LENGTH_ADJUSTMENT_TRUNCATE
    length_figure > LENGTH_TRUNCATE_DEFAULT ? length_figure : LENGTH_TRUNCATE_DEFAULT
  end
end
