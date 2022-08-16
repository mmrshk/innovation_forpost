# frozen_string_literal: true

class ArticlePresenter
  include ActionView::Helpers
  include ActionView::Context
  include Rails.application.routes.url_helpers

  IMAGE_SRC_REGEX = /src="(.*?)"/
  FIGURE_REGEX = %r{<figure[^>]+>[\s\S]*?</figure>}
  TAG_FIGURE_REGEX = /<figure[^>]/
  TEXT_WITH_FIGURE_REGEX = %r{[\s\S]*?</figure>}
  LENGTH_TRUNCATE_DEFAULT = 500

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

  def truncate_article_text
    truncate(@article.text.to_s, escape: false, length: length_truncate, omission: '') do
      link_to '...Continue', controller: 'articles', action: 'show', id: @article.id
    end
  end

  private

  def first_article_image
    @article.text.match(IMAGE_SRC_REGEX)[1] if @article.text.match(IMAGE_SRC_REGEX)
  end

  def remove_first_article_image(text)
    text.gsub! @article.text.scan(FIGURE_REGEX).first, ''
    # TODO: Maybe, better hide all figures from the truncated text
  end

  def length_truncate
    truncate_text = truncate(@article.text.to_s, length: LENGTH_TRUNCATE_DEFAULT, escape: false)
    check_figure_present(truncate_text)
  end

  def check_figure_present(text)
    text.match(TAG_FIGURE_REGEX) ? check_length(text) : LENGTH_TRUNCATE_DEFAULT
  end

  def check_length(text)
    length_figure = text.match(TEXT_WITH_FIGURE_REGEX).to_s.length
    length_figure > LENGTH_TRUNCATE_DEFAULT ? length_figure : LENGTH_TRUNCATE_DEFAULT
  end
end
