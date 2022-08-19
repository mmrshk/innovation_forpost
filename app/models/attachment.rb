# frozen_string_literal: true

class Attachment < ApplicationRecord
  has_one_attached :media_file

  validates :name, presence: true, length: { in: 6..20 }
  validates :media_file, attached: true, content_type: %i[png jpg jpeg png],
                         size: { less_than: 5.megabytes, message: 'is too large' }
end
