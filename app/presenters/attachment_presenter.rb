# frozen_string_literal: true

class AttachmentPresenter
  include ActionView::Helpers
  include ActionView::Context
  include Rails.application.routes.url_helpers

  def initialize(attachment)
    @attachment = attachment
  end

  def check_media_file_for_preview
    if @attachment.media_file.image?
      link_to image_tag(media_file_blob_url,
                        size: '84x84',
                        class: 'image-attachment'),
              admins_attachment_path(@attachment)
    else
      link_to content_tag(:i, 'insert_drive_file', class: 'material-icons large'),
              media_file_blob_url, target: '_blank'
    end
  end

  def check_media_file_for_show
    if @attachment.media_file.image?
      image_tag(media_file_blob_url, class: 'view-attachment-img')
    else
      link_to content_tag(:div, I18n.t('admin.attachments.view_docs_button'), class: 'view-attachment-links'),
              media_file_blob_url, target: '_blank', class: 'btn-view-docs'
    end
  end

  def media_file_filename
    return unless @attachment.media_file.attached?

    content_tag :div, class: 'file-name-group' do
      content_tag(:span, I18n.t('admin.attachments.file_name'), class: 'file-name-label') +
        content_tag(:span, @attachment.media_file.blob.filename, class: 'file-name')
    end
  end

  def media_file_blob_url
    Rails.application.routes.url_helpers.rails_blob_url(
      @attachment.media_file.blob,
      Rails.application.config.action_mailer.default_url_options
    )
  end
end
