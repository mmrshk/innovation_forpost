# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = Article.published.in_language(extract_locale).sorted_desc
  end

  def show
    @article = Article.find(params[:id])
  end
end
