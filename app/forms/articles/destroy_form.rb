# frozen_string_literal: true

module Articles
  class DestroyForm < Articles::BaseForm
    def save
      ActiveRecord::Base.transaction do
        save_article_tags!
        @article.destroy!
        check_and_destroy_tags!
        raise ActiveRecord::Rollback unless errors.empty?
      end

      errors.empty?
    end

    private

    def save_article_tags!
      @article_tags_list = @article.tags
    end

    def check_and_destroy_tags!
      @article_tags_list.each do |tag|
        tag.destroy! if tag.present? && tag.articles.count < 1
      end
    end
  end
end
