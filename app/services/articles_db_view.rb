# frozen_string_literal: true

module DbViewer
  class ArticlesDbViewer
    def call
      ArticlesDbView.all
    end
  end
end
