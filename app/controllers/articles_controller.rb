# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotDestroyed, with: :article_not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :article_not_found

  def index
    @articles = Article.sorted.paginate(page: params[:page])
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: 'The article was successfully created.'
    else
      flash.now[:alert] = 'Could not create the article. Please try again'
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: 'The article was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    article = set_article.destroy
    redirect_to articles_path, notice: "The article '#{article.title}' was successfully destroyed."
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :user_id, :language, :status)
  end

  def article_not_destroyed(err)
    message_result_deleted = "Article failed to delete: #{err.record.errors.full_messages}"
    redirect_to articles_path, notice: message_result_deleted
  end

  def article_not_found
    flash[:notice] = 'Article not found'
    redirect_to articles_path # redirect_to page_404
  end
end
