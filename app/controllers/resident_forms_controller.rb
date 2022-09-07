# frozen_string_literal: true

class ResidentFormsController < ApplicationController
  def new
    @resident = ResidentForm.new
  end

  def create
    @resident = ResidentForm.new(resident_params)
    respond_to do |format|
      if @resident.save
        format.html { redirect_to root_path, notice: 'Resident was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def resident_params
    params.require(:resident_form).permit(:customer_full_name, :in_person, :project_name,
                                          :address, :phone_email, :purpose, :activity, :area,
                                          :danger_class, :electicity_supply, :reqirements)
  end
end
