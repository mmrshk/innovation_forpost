# frozen_string_literal: true

class ArticlePresenter
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  IMAGE_SRC_REGEX = /src="(.*?)"/
  FIGURE_REGEX = %r{<figure[^>]+>[\s\S]*?</figure>}

  def initialize(article)
    @article = article
  end

  def all_tags
    @article.tags.present? ? @article.tags.pluck(:name).join(', ') : ''
  end

  def article_preview_text
    text_for_preview = @article.text.dup
    @article.text.scan(FIGURE_REGEX).any? ? remove_first_article_image(text_for_preview) : @article.text
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

  private

  def first_article_image
    @article.text.match(IMAGE_SRC_REGEX)[1] if @article.text.match(IMAGE_SRC_REGEX)
  end

  def remove_first_article_image(text)
    text.gsub! @article.text.scan(FIGURE_REGEX).first, ''
    # TODO: Maybe, better hide all figures from the truncated text
  end
end
