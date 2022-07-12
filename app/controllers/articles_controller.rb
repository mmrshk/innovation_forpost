# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.where(status: 1)
  end

  def show
    @article = Article.find(params[:id])
  end
end
