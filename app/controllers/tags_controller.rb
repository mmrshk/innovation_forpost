# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @presenters = @tag.articles.map { |article| ArticlePresenter.new(article) }
  end
end
