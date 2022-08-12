# frozen_string_literal: true

class CkEditorImageService
  attr_reader :uploaded_image

  def initialize(file)
    @file = file
  end

  def save
    @uploaded_image = CkEditorImage.new(file: @file)

    @uploaded_image.save ? update_image_url : false
  end

  private

  def update_image_url
    @uploaded_image.update(url: @uploaded_image.file.url)
  end
end
