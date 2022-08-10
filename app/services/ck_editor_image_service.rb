# frozen_string_literal: true

class CkEditorImageService
  def initialize(params)
    @file = params
  end

  def save
    @uploaded_image = CkEditorImage.new(file: @file)
    update_image_url if @uploaded_image.save
  end

  def file
    @uploaded_image.file
  end

  def errors
    @uploaded_image.errors.full_messages
  end

  private

  def update_image_url
    @uploaded_image.update(url: @uploaded_image.file.url)
  end
end
