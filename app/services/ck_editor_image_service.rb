# frozen_string_literal: true

class CkEditorImageService
  attr_reader :uploaded_image

  def initialize(file)
    @file = file
  end

  def save
    @uploaded_image = CkEditorImage.new(file: @file)

    update_image_url if @uploaded_image.save
  end

  private

  def update_image_url
    @uploaded_image.update(url: @uploaded_image.file.url)
  end
end
