class Document < ApplicationRecord
  validates :name, presence: true

  has_ancestry
end
