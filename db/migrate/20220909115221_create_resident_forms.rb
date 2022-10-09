class CreateResidentForms < ActiveRecord::Migration[6.0]
  def change
    create_table :resident_forms do |t|
      t.string :customer_full_name, null: false
      t.string :in_person, null: false
      t.string :project_name, null: false
      t.string :address, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :purpose, null: false
      t.string :activity, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :area, null: false
      t.integer :danger_class, null: false
      t.boolean :electicity_supply, null: false
      t.text :reqirements

      t.timestamps
    end
  end
end
