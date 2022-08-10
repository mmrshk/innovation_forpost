# frozen_string_literal: true

module Articles
  class CreateUpdateForm < Articles::BaseForm
    IMAGE_SRC_REGEX = /src="(.*?)"/

    def save
      return false unless valid?

      ActiveRecord::Base.transaction do
        create_or_update_attributes!
        set_article_to_image!
        set_article_tags!

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

    def set_article_tags!
      @article.tags = tag_list(params[:tags])
    end

    def check_storage
      CkEditorImageUploader.storage == CarrierWave::Storage::Fog ? 6 : 4
    end

    def image_ids
      @image_ids ||= @article.text.scan(IMAGE_SRC_REGEX).map do |tag_img|
        tag_img[0].split('/')[check_storage].to_i
      end
    end

    def set_article_to_image!
      return if image_ids.blank?

      image_ids.each { |image_id| CkEditorImage.find(image_id).update!(article_id: @article.id) }
    end
  end
end
