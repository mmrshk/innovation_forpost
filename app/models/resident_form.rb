# frozen_string_literal: true

class ResidentForm < ApplicationRecord
  validates :customer_full_name, presence: true
  validates :in_person, presence: true
  validates :project_name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :purpose, presence: true
  validates :activity, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :area, presence: true
  validates :danger_class, presence: true
  validates :electicity_supply, presence: true
end
