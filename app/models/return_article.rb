# frozen_string_literal: true

class ReturnArticle < ActiveRecord::Base
  self.primary_key = :id

  def readonly?
    true
  end
end
