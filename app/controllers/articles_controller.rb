# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = if params[:search]
                  articles.articles_search(params[:search]).sorted_desc
                elsif params[:q]
                  Tag.find_by(name: params[:q]).articles.published.in_language(extract_locale)
                else
                  articles.sorted_desc
                end

    @tags = Tag.joins(article_tags: :article).where('articles.language = ?', Article::LANGUAGES[extract_locale])
  end

  def show
    return not_found unless Article.find(params[:id]).published?

    @article = Article.find(params[:id])
    authorize @article
  end

  def not_found
    render 'errors/not_found'
  end

  private

  def articles
    @articles = policy_scope(Article.includes(:article_tags, :tags).published.in_language(extract_locale))
  end
end
