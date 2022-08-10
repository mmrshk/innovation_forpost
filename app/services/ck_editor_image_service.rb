# frozen_string_literal: true

class CkEditorImageService
  def initialize(image)
    @image = image
  end

  def update_image_url
    @image.update(url: @image.file.url)
  end
end
