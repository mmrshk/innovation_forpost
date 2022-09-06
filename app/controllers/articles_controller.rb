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
    return not_found unless Article.find(params[:id]).published?

    @article = Article.find(params[:id])
  end

  def not_found
    render 'errors/not_found'
  end
end
