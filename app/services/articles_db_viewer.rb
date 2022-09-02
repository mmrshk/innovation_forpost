# frozen_string_literal: true

class ArticlesDbViewer
  def self.call
    ArticlesDbView.all
  end
end
