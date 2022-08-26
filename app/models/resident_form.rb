class ResidentForm < ApplicationRecord
  validates :customer_full_name, presence: true
end
