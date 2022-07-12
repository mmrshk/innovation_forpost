# frozen_string_literal: true

module Articles
  class CreateForm
    include ActiveModel::Model

    attr_accessor :params, :article_tags

    def initialize(current_user:, params:)
      @user = current_user
      @params = params
    end

    def save
      return false unless valid?

      ActiveRecord::Base.transaction do
        create_article!
        create_article_tags!

        raise ActiveRecord::Rollback unless errors.empty?
      end

      errors.empty?
    end

    private

    def create_article!
      @article = Article.create!(params)
    end

    def create_article_tags!
      return unless params[:article_tags]&.empty?

      @article.article_tags.create!(params[:article_tags])
    end
  end
end
