# frozen_string_literal: true

module Admins
  class ArticlesController < AdminsController
    before_action :article, only: %i[show edit update destroy]

    def index
      @q = Article.ransack(params[:q])
      @pagy, @articles = pagy(@q.result.includes(:user).not_trashed.sorted_desc)
    end

    def show; end

    def new
      @form = Articles::BaseForm.new(params: {})
      @presenter = ArticlePresenter.new(@form.article)
    end

    def create
      @form = Articles::CreateUpdateForm.new(params: article_params)
      @presenter = ArticlePresenter.new(@form.article)
      if @form.save
        redirect_to admins_articles_path, notice: I18n.t('admins.articles.create_success')
      else
        flash.now[:alert] = I18n.t('admins.articles.create_unsuccess')
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @form = Articles::BaseForm.new(params: {}, article: article)
      @presenter = ArticlePresenter.new(@form.article)
    end

    def update
      @form = Articles::CreateUpdateForm.new(params: article_params, article: article)
      @presenter = ArticlePresenter.new(@form.article)
      if @form.save
        redirect_to admins_articles_path, notice: I18n.t('admins.articles.update_success')
      else
        flash.now[:alert] = I18n.t('admins.articles.update_unsuccess')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @form = Articles::DestroyForm.new(params: {}, article: article)
      if @form.save
        redirect_to admins_articles_path, notice: I18n.t('admins.articles.destroy_success')
      else
        flash[:notice] = article.errors
      end
    end

    def upload
      @image = CkEditorImageService.new(params[:upload])
      if @image.save
        render json: { url: @image.uploaded_image.url }
      else
        render json: {
          error: {
            message:
              I18n.t('admins.articles.upload_image_unsuccess', errors: @image.uploaded_image.errors.messages.join(', '))
          }
        }, status: :unprocessable_entity
      end
    end

    private

    def article
      @article ||= Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :text, :user_id, :language, :status, :tags, :locale)
    end
  end
end
