class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.integer :start_year, default: 2010
      t.integer :projects_count, default: 0
      t.integer :clients_count, default: 0
      t.integer :grants_count, default: 0
      t.string :text_about, null: false
      t.string :logo

      t.timestamps
    end
  end
end
