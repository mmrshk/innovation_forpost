# frozen_string_literal: true

module Articles
  class BaseForm
    include ActiveModel::Model

    attr_accessor :params,
                  :article,
                  :article_tags,
                  :user_id,
                  :title,
                  :text,
                  :status,
                  :language,
                  :tags

    validates_presence_of :title, :text, :user_id, :language, :status

    def initialize(params:, article: Article.new)
      @params = params
      @article = article

      super(params)
    end
  end
end
