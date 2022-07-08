# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

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
      redirect_to @article, notice: I18n.t('controllers.admin.article.create_success')
    else
      flash.now[:alert] = I18n.t('controllers.admin.article.create_unsuccess')
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: I18n.t('controllers.admin.article.create_unsuccess')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    article = set_article
    if @article.destroy!
      redirect_to articles_path, notice: "#{I18n.t('controllers.admin.article.destroy_success_1')}'#{article.title}'
      #{I18n.t('controllers.admin.article.destroy_success_2')}"
    else
      flash[:notice] = @article.errors
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :user_id, :language, :status, :tag_list)
  end
end
