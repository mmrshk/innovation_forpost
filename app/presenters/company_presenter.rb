# frozen_string_literal: true

class CompanyPresenter
  def initialize(company)
    @company = company
  end

  def company_info
    [Date.today.year - @company.start_year,
     @company.projects_count,
     @company.clients_count,
     @company.grants_count]
  end

  def company_label_texts
    [I18n.t('companies.labels.years_text'),
     I18n.t('companies.labels.projects_text'),
     I18n.t('companies.labels.clients_text'),
     I18n.t('companies.labels.grants_text')]
  end
end
