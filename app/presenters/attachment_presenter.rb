# frozen_string_literal: true

class AttachmentPresenter
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  def initialize(attachment)
    @attachment = attachment
  end

  def check_media_file_for_preview
    if @attachment.media_file.image?
      link_to image_tag(@attachment.media_file_blob_url,
                        size: '84x84',
                        class: 'image-attachment'),
              admins_attachment_path(@attachment)
    else
      link_to content_tag(:i, 'insert_drive_file', class: 'material-icons large'),
              @attachment.media_file_blob_url, target: '_blank'
    end
  end

  def check_media_file_for_url
    @attachment.media_file.image? ? admins_attachment_path(@attachment) : @attachment.media_file_blob_url
  end
end
