class CreateResidentForms < ActiveRecord::Migration[6.0]
  def change
    create_table :resident_forms do |t|
      t.string :customer_full_name
      t.string :in_person
      t.string :project_name
      t.string :address
      t.string :phone_email
      t.string :purpose
      t.string :activity
      t.integer :area
      t.integer :danger_class
      t.boolean :electicity_supply
      t.text :reqirements

      t.timestamps
    end
  end
end
