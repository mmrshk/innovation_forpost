# frozen_string_literal: true

class TagsController < ApplicationController
  # before_action :set_tag, only: %i[show]
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    # @tag.articles
  end

  # private

  # def set_article
  #   @tag = Tag.find(params[:id])
  # end
end
