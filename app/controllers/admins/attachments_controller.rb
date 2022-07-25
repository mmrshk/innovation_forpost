# frozen_string_literal: true

module Admins
  class AttachmentsController < ApplicationController
    before_action :find_attachment, only: %i[show edit update destroy]

    def index
      @attachments = Attachment.all
    end

    def show; end

    def new
      @attachment = Attachment.new
    end

    def create
      @attachment = Attachment.new(attachment_params)
      if @attachment.save
        flash[:success] = 'You added a new attachment!'
        redirect_to admins_attachments_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @attachment.update(attachment_params)
        flash[:success] = 'You successfully edited an attachment!'
        redirect_to admins_attachment_path(@attachment.id)
      else
        render :edit
      end
    end

    def destroy
      @attachment.destroy
      flash[:success] = 'You deleted an attachment!'
      redirect_to admins_attachments_path
    end

    private

    def find_attachment
      @attachment = Attachment.find(params[:id])
    end

    def attachment_params
      params.require(:attachment).permit(:name, :media_file)
    end
  end
end
