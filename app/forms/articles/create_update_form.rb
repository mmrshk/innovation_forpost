# frozen_string_literal: true

module Articles
  class CreateUpdateForm < Articles::BaseForm
    IMAGE_SRC = /src="(.*?)"/

    def save
      return false unless valid?

      ActiveRecord::Base.transaction do
        create_or_update_attributes!
        @article.tags = tag_list(params[:tags])
        image_ids!
        set_article_to_image!
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

    def image_ids!
      @article.text.scan(IMAGE_SRC) do |img_tag|
        (@image_ids ||= []) << img_tag[0].split('/')[4].to_i
      end
    end

    def set_article_to_image!
      return if @image_ids.blank?

      @image_ids.each { |image| CkEditorImage.find(image).update!(article_id: @article.id) }
    end
  end
end
