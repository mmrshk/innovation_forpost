# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = if !params[:q] || params[:q].empty?
                  articles.sorted_desc
                else
                  articles.articles_search(params[:q]).sorted_desc
                end

    @tags = Tag.joins(article_tags: :article).where('articles.language = ?', Article::LANGUAGES[extract_locale])
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
