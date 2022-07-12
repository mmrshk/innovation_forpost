# frozen_string_literal: true

# module Articles
#   class BaseForm
#     include ActiveModel::Model

#     attr_accessor :article, :article_tags, :user, :title, :text, :status, :language
#     # attr_accessor :params

#     # validates :category, :content, :article_tags, presence: true
#     # validate :user_is_admin?, :tag_ids_exists?

#     def initialize(params, user, article = nil)
#       @article = article
#       @user = user

#       super(params)
#     end

#     private

#     def create_article_tags!
#       tags.each { |tag| article.article_tags.create!(tag: tag) }
#     end

#     # def user_is_admin?
#     #   errors.add(:base, 'You are not authorised for this action') unless user.is_a?(Admin)
#     # end

#     def tag_ids_exists?
#       errors.add(:base, 'Tag ids invalid') unless article_tags && article_tags[:tag_ids].count == tags.count
#     end

#     def tags
#       @tags ||= Tag.where(id: article_tags[:tag_ids])
#     end
#   end
# end
