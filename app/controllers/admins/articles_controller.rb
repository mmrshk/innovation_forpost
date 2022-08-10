# frozen_string_literal: true

module Admins
  class ArticlesController < AdminsController
    before_action :article, only: %i[show edit update destroy]

    def index
      @articles = Article.includes(:user).not_trashed.sorted_desc
    end

    def show; end

    def new
      @form = Articles::BaseForm.new(params: {})
    end

    def create
      @form = Articles::CreateUpdateForm.new(params: article_params)
      if @form.save
        redirect_to admins_articles_path, notice: I18n.t('admins.articles.create_success')
      else
        flash.now[:alert] = I18n.t('admins.articles.create_unsuccess')
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @form = Articles::BaseForm.new(params: {}, article: article)
    end

    def update
      @form = Articles::CreateUpdateForm.new(params: article_params, article: article)
      if @form.save
        redirect_to admins_articles_path, notice: I18n.t('admins.articles.update_success')
      else
        flash.now[:alert] = I18n.t('admins.articles.update_unsuccess')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if article.destroy
        redirect_to admins_articles_path, notice: I18n.t('admins.articles.destroy_success')
      else
        flash[:notice] = article.errors
      end
    end

    def upload
      @image = CkEditorImage.new(file: params[:upload])
      if @image.save
        render json: {
          url: @image.file.url
        }
      else
        render json: {
          error: {
            message: "The image upload failed. Error: #{@image.errors.full_messages.join(', ')}"
          }
        }
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
