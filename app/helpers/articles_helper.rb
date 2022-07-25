# frozen_string_literal: true

module ArticlesHelper
  def date_as_month_and_year(date)
    date.strftime('%F')
  end
end
