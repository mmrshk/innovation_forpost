# frozen_string_literal: true

class AttachmentsController < ApplicationController
  def show
    @attachment = Attachment.find(params[:id])
    @presenter = AttachmentPresenter.new(@attachment)
  end

  def download
  end
end
