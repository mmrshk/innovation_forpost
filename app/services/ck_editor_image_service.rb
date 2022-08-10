# frozen_string_literal: true

class CkEditorImageService
  def initialize(image:, image_url:)
    @image = image
    @image_url = image_url
  end

  def update_image_url
    @image.update(url: @image_url)
  end
end
