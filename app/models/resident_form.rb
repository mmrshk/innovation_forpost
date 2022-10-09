# frozen_string_literal: true

class ResidentForm < ApplicationRecord
  validates :customer_full_name, :in_person, :project_name, :address, :phone, :email, :purpose, :activity, :start_date,
            :end_date, :area, :danger_class, :electicity_supply, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
