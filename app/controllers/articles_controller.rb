# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:article_tags, :tags).published.in_language(extract_locale).sorted_desc
    @tags = Tag.all
    @presenters = @articles.map { |article| ArticlePresenter.new(article) }
  end

  def show
    return not_found unless Article.find(params[:id]).published?

    @article = Article.find(params[:id])
  end

  def not_found
    render 'errors/not_found'
  end
end
