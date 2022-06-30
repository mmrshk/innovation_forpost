class CreateArticles < ActiveRecord::Migration[6.0]
  
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.references :user, null: false, foreign_key: true
      # t.references :autor, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
    add_index :articles, [:user_id, :created_at]
    # add_index :articles, [:autor, :created_at]
  end
end
