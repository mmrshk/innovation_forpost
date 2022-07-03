# frozen_string_literal: true

module ArticleHelper
  VALID_STATUSES = {
    draft: 0,
    published: 1,
    trashed: 2
  }.freeze
  LANGUAGES = {
    ukr: 0,
    eng: 1
  }.freeze
end
