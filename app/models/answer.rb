# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true, length: { minimum: 2, maximum: 1000 }
end
