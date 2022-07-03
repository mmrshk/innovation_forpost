class Attachment < ApplicationRecord
  has_one_attached :media_file

  validates :media_file, attached: true, content_type: [:png, :jpg, :jpeg]
end
