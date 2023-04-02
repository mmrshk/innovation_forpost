# frozen_string_literal: true

module Admins
  class AttachmentsController < ApplicationController
    before_action :attachment, only: %i[show edit update destroy]
    before_action :authenticate_user!
    before_action :presenter, only: %i[show new create edit update]
    before_action :authorize_attachment, only: %i[show edit update destroy]

    def index
      @attachments = policy_scope(Attachment)
      @q = @attachments.ransack(params[:q])
      @pagy, @attachments = pagy(@q.result.includes(media_file_attachment: :blob).all)
    end

    def show; end

    def new
      @attachment = Attachment.new
      authorize @attachment
    end

    def create
      @attachment = Attachment.new(attachment_params)
      authorize @attachment
      if @attachment.save
        flash[:success] = I18n.t('admins.attachments.create_attachment')
        redirect_to admins_attachments_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @attachment.update(attachment_params)
        flash[:success] = I18n.t('admins.attachments.edit_attachment')
        redirect_to admins_attachment_path(@attachment.id)
      else
        render :edit
      end
    end

    def destroy
      @attachment.destroy
      flash[:success] = I18n.t('admins.attachments.delete_attachment')
      redirect_to admins_attachments_path
    end

    private

    def attachment
      @attachment ||= Attachment.find(params[:id])
    end

    def authorize_attachment
      authorize @attachment
    end

    def presenter
      @presenter ||= AttachmentPresenter.new(@attachment)
    end

    def attachment_params
      params.require(:attachment).permit(:name, :media_file)
    end
  end
end
