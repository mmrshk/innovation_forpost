# frozen_string_literal: true

module Articles
  class DestroyForm < Articles::BaseForm
    def save
      ActiveRecord::Base.transaction do
        check_and_destroy_tags!
        @article.destroy!
        raise ActiveRecord::Rollback unless errors.empty?
      end

      errors.empty?
    end

    private

    def check_and_destroy_tags!
      @article.tags.each do |tag|
        tag.destroy! if tag.articles.one? && tag.articles.include?(@article)
      end
    end
  end
end
