# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = if !params[:query] || params[:query].empty?
                  articles.sorted_desc
                else
                  articles.articles_search(params[:query]).sorted_desc
                end
    @tags = Tag.all
  end

  def show
    return not_found unless Article.find(params[:id]).published?

    @article = Article.find(params[:id])
  end

  def not_found
    render 'errors/not_found'
  end

  private

  def articles
    @articles ||= Article.includes(:article_tags, :tags).published.in_language(extract_locale)
  end
end
