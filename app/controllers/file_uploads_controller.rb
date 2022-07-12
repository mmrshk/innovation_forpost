# frozen_string_literal: true

class FileUploadsController < ApplicationController
  def new
    @attachment = CkEditorImage.new
  end

  def upload
    @attachment = CkEditorImage.new(file: params['upload'])
    if @attachment.save
      render json: {
        url: @attachment.file.url
      }
    else
      render json: {
        error: {
          message: @attachment.errors.full_messages.join(', ')
        }
      }
    end
  end
end
