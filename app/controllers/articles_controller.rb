# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.published.in_language(extract_locale).sorted_desc
    @search = Article.articles_search(params[:query])
    @tags = Tag.all
  end

  def show
    @article = Article.find(params[:id])
  end
end
