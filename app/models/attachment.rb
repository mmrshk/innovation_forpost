class Attachment < ApplicationRecord
  has_one_attached :media_file

  validates :media_file, blob: { content_type: [':png', ':pdf', ':jpg', ':jpeg']  }

end
