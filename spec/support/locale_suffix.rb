# frozen_string_literal: true

module LocaleSuffix
  def locale_suffix(path)
    "#{path}?locale=#{I18n.locale}"
  end
end
