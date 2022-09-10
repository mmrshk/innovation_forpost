# frozen_string_literal: true

class AttachmentPresenter
  include ActionView::Helpers
  include ActionView::Context
  include Rails.application.routes.url_helpers

  ATTACHMENTS_TYPES = {
    pdf: 'application/pdf',
    docx: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    png: 'image/png',
    jpeg: 'image/jpeg',
    jpg: 'image/jpeg'
  }.freeze

  def initialize(attachment)
    @attachment = attachment
  end

  def check_media_file_for_preview
    link_to image_tag(icon_for_preview, size: '84x84'), attachment_path(@attachment, locale: I18n.locale)
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
    return if @attachment.nil? || !@attachment.media_file.attached?

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

  private

  def attachment_type
    @attachment.media_file.blob.content_type
  end

  def icon_for_preview
    image_types = %i[png jpeg jpg]
    case ATTACHMENTS_TYPES.key(attachment_type)
    when *image_types
      media_file_blob_url
    when :pdf
      '/icons/pdf-file.png'
    when :docx
      '/icons/doc-file.png'
    else
      '/icons/other-file.png'
    end
  end
end
