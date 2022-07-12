# frozen_string_literal: true

module Admin
  class ArticlesController < ApplicationController
    def index
      @articles = Article.where.not(status: 2)
    end

    def show
      article
    end

    def new
      @article = Article.new
      # current_user = User.first
      # @form = Articles::BaseForm.new({}, current_user)
    end

    def create
      @create_form = Articles::CreateForm.new(current_user: current_user, params: article_params)

      if @create_form.save
        redirect_to admin_articles_path, notice: I18n.t('controllers.admin.article.create_success')
      else
        flash.now[:alert] = I18n.t('controllers.admin.article.create_unsuccess')
        render :new
      end
    end

    def edit
      # article
      current_user = User.first
      @form = Articles::BaseForm.new({}, current_user)
    end

    def update
      if article.update(article_params)
        # redirect_to admin_articles_path, notice: I18n.t('controllers.admin.article.create_success')
        redirect_to article_path(article), notice: I18n.t('controllers.admin.article.update_success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if article.destroy
        redirect_to admin_articles_path, notice: I18n.t('controllers.admin.article.destroy_success')
      else
        flash[:notice] = article.errors
      end
    end

    def upload
      @attachment = CkEditorImage.new(file: params[:upload])
      if @attachment.save
        render json: {
          url: @attachment.file.url
        }
      else
        render json: {
          error: {
            message: "The image upload failed. Error: #{@attachment.errors.full_messages.join(', ')}"
          }
        }
      end
    end

    private

    def article
      @article ||= Article.find(params[:id])
    end

    def article_params
      # params.require(:article).permit(:title, :text, :user_id, :language, :status, :tag_list, :attachment_params)
      params.require(:article).permit(:title, :text, :user_id, :user, :language, :status, article_tags: [tag_ids: []])
    end
  end
end
