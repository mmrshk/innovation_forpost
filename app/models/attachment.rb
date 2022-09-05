# frozen_string_literal: true

class Attachment < ApplicationRecord
  has_one_attached :media_file

  validates :name, presence: true, length: { in: 6..200 }
  validates :media_file, attached: true, content_type: %i[png jpg jpeg pdf doc docx],
                         size: { less_than: 5.megabytes, message: 'is too large' }

  def media_file_blob_url
    Rails.application.routes.url_helpers.rails_blob_url(
      media_file.blob,
      Rails.application.config.action_mailer.default_url_options
    )
  end
end
