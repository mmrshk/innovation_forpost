# frozen_string_literal: true

class ArticlePresenter
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
  include ActionView::Context

  def initialize(article)
    @article = article
  end

  def all_tags
    @article.tags.present? ? @article.tags.pluck(:name).join(', ') : ''
  end

  def truncate_article_text
    truncate(@article.text.to_s, escape: false,
                                 length: truncate_params[:length_truncate],
                                 separator: truncate_params[:separator_truncate]) do
      link_to 'Continue', controller: 'articles', action: 'show', id: @article.id
    end
  end

  private

  def truncate_params
    length_truncate = 500
    article_text = @article.text.to_s
    truncate_text = truncate(article_text, length: length_truncate, escape: false)
    if truncate_text.match(/<figure[^>]/)
      length_truncate_figure = article_text.match(%r{[\s\S]*?</figure>}).to_s.length + 3
      truncate_text_figure = truncate(article_text, length: length_truncate_figure, escape: false)
      if truncate_text_figure.length > truncate_text.length
        length_truncate = length_truncate_figure
      else
        last_closing_tag = truncate_text.scan(%r{((</)\w+(>))}).last[0]
        separator_truncate = last_closing_tag
      end
    end
    { length_truncate: length_truncate,
      separator_truncate: separator_truncate }
  end
end
