# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    if params[:q]
      @articles = Tag.find_by(name: params[:q]).articles.published.in_language(extract_locale)
    else
      @articles = Article.all.includes(:article_tags, :tags).published.in_language(extract_locale)
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
end
