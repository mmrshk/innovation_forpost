# frozen_string_literal: true

module Articles
  class CreateUpdateForm < Articles::BaseForm
    def save
      return false unless valid?

      ActiveRecord::Base.transaction do
        create_or_update_attributes!
        @article.tags = tag_list(params[:tags])
        @article.save!
        raise ActiveRecord::Rollback unless errors.empty?
      end

      errors.empty?
    end

    private

    def create_or_update_attributes!
      @article = Article.find_or_initialize_by(id: @article.id)

      @article.tap do |record|
        record.assign_attributes(params.slice(:title, :text, :user_id, :status, :language))
        record.save!
      end
    end

    def tag_list(tags_string)
      if tags_string.nil?
        []
      else
        tags_string.split(',')
                   .collect { |s| s.strip.downcase }
                   .uniq
                   .collect { |name| Tag.find_or_create_by(name: name) }
      end
    end
  end
end
