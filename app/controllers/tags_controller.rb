# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    @tags = policy_scope(Tag)
  end

  def show
    @tag = Tag.find(params[:id])
    authorize @tag
  end
end
