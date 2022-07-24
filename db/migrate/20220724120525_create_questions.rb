class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :user_name
      t.string :user_email
      t.text :body

      t.timestamps
    end
  end
end
