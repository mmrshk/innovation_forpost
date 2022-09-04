# frozen_string_literal: true

class CompaniesController < ApplicationController
  def index
    @companies = Company.includes(media_file_attachment: :blob).in_language(extract_locale)
    @articles = Article.published.in_language(extract_locale).sorted_desc
    @documents = Attachment.includes(media_file_attachment: :blob).all
  end
end
