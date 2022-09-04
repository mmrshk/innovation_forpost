# frozen_string_literal: true

class ArticlesController < ApplicationController
  # rubocop:disable Metrics/AbcSize
  def index
    @articles = if !params[:query] || params[:query].empty?
                  Article.includes(:article_tags, :tags).published.in_language(extract_locale).sorted_desc
                else
                  Article.includes(:article_tags,
                                   :tags).published.in_language(extract_locale).articles_search(params[:query])
                end
    @tags = Tag.all
  end
  # rubocop:enable Metrics/AbcSize

  def show
    return not_found unless Article.find(params[:id]).published?

    @article = Article.find(params[:id])
  end

  def not_found
    render 'errors/not_found'
  end
end
