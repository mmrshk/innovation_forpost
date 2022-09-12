# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = unless params[:query] || params[:query].present?
                  articles.sorted_desc
                else
                  articles.articles_search(params[:query]).sorted_desc
                end
    @tags = Tag.all
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
