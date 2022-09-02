# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = if !params[:query] || params[:query].empty?
                  Article.published.in_language(extract_locale).sorted_desc
                else
                  Article.articles_search(params[:query])
                end
    @tags = Tag.all
  end

  def show
    @article = Article.find(params[:id])
  end
end
