class AddLanguageToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :language, :integer, default: 0
  end
end
