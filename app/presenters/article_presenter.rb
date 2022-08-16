# frozen_string_literal: true

class ArticlePresenter
  include ActionView::Helpers
  include ActionView::Context
  include Rails.application.routes.url_helpers

  IMAGE_SRC_REGEX = /src="(.*?)"/
  FIGURE_REGEX = %r{<figure[^>]+>[\s\S]*?</figure>}
  LENGTH_TRUNCATE_DEFAULT = 300

  def initialize(article)
    @article = article
  end

  def all_tags
    @article.tags.present? ? @article.tags.pluck(:name).join(', ') : ''
  end

  def article_preview_text
    truncate_article_text
  end

  def article_preview_image
    return unless first_article_image

    link_to image_tag(first_article_image,
                      alt: @article.title,
                      class: 'image-preview'),
            controller: 'articles',
            action: 'show',
            id: @article.id
  end

  def first_article_image
    @article.text.match(IMAGE_SRC_REGEX)[1] if @article.text.match(IMAGE_SRC_REGEX)
  end

  private

  def truncate_article_text
    truncate(check_text_figure_present, escape: false, length: LENGTH_TRUNCATE_DEFAULT) do
      link_to 'Continue', controller: 'articles', action: 'show', id: @article.id
    end
  end

  def check_text_figure_present
    text_for_preview = @article.text.dup
    @article.text.scan(FIGURE_REGEX).any? ? remove_article_figures(text_for_preview) : @article.text
  end

  def remove_article_figures(text)
    @article.text.scan(FIGURE_REGEX).each { |figure| text.gsub! figure, '' }
    text
  end
end
