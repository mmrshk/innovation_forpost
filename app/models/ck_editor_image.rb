# frozen_string_literal: true

class CkEditorImage < ApplicationRecord
  mount_uploader :file, CkEditorImageUploader
  belongs_to :article, optional: true

  validates_presence_of :file
end