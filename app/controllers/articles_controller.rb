# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.published.sorted_desc
  end

  def show
    @article = Article.find(params[:id])
  end
end
