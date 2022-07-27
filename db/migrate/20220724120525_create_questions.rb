class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.string :user_name, null: false
      t.string :user_email
      t.text :body, null: false

      t.timestamps
    end
  end
end
