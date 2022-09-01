# frozen_string_literal: true

module Admins
  class CompaniesController < AdminsController
    before_action :company, only: %i[show edit update destroy]

    def index
      @pagy, @companies = pagy(Company.all)
    end

    def show; end

    def new
      @company = Company.new
    end

    def create
      @company = Company.new(company_params)

      if @company.save
        redirect_to admins_companies_path, notice: I18n.t('admins.companies.create_success')
      else
        flash.now[:alert] = I18n.t('admins.companies.create_unsuccess')
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @company.update(company_params)
        redirect_to admins_companies_path, notice: I18n.t('admins.companies.update_success')
      else
        flash.now[:alert] = I18n.t('admins.companies.update_unsuccess')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @company.destroy
        redirect_to admins_companies_path, notice: I18n.t('admins.companies.destroy_success')
      else
        flash[:notice] = @company.errors
      end
    end

    private

    def company
      @company ||= Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name,
                                      :start_year,
                                      :projects_count,
                                      :clients_count,
                                      :grants_count,
                                      :text_about,
                                      :media_file)
    end
  end
end
