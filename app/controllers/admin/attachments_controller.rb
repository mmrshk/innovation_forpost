# frozen_string_literal: true

module Admin
  class AttachmentsController < ApplicationController
    def index
      @attachments = Attachment.all
    end

    def show
      @attachment = Attachment.find(params[:id])
    end

    def new
      @attachment = Attachment.new
    end

    def create
      @attachment = Attachment.new(attachment_params)
      if @attachment.save
        flash[:success] = 'You added a new attachment!'
        redirect_to admin_attachments_path
      else
        render :new
      end
    end

    def edit
      @attachment = Attachment.find(params[:id])
    end

    def update
      @attachment = Attachment.find(params[:id])
      if @attachment.update(attachment_params)
        flash[:success] = 'You successfully edited an attachment!'
        redirect_to admin_attachment_path(@attachment.id)
      else
        render :edit
      end
    end

    def destroy
      attachment = Attachment.find(params[:id])
      if attachment.destroy
        flash[:success] = 'You deleted an attachment!'
        redirect_to admin_attachments_path
      end
    end

    private

    def attachment_params
      params.require(:attachment).permit(:name, :media_file)
    end
  end
end
