# frozen_string_literal: true

class Attachment < ApplicationRecord
  has_one_attached :media_file

  validates :name, presence: true
  validates :media_file, attached: true, content_type: %i[png jpg jpeg]
end
