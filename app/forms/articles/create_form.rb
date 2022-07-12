# frozen_string_literal: true

module Articles
  class CreateForm
    include ActiveModel::Model

    attr_accessor :params, :article_tags

    # def initialize(params, user)
    #   @params = params
    #   @user = user

    #   # super(params)
    # end

    def initialize(user, params = {})
      @user = user
      @params = params
      # super(params)
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
      @article = @user.articles.create!(params[:article])
      # @article = Article.create!(params[:article])
    end

    def create_article_tags!
      @article.article_tags.create!(params[:article_tags])
    end
  end
end
