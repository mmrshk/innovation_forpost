class CreateArticles < ActiveRecord::Migration[6.0]

  # def up
  #   execute <<-SQL
  #     CREATE TYPE status AS ENUM ('draft', 'published', 'trashed');
  #   SQL
  # end
  
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.string :autor, null: false
      # t.string :status, default: 0, null: false

      t.timestamps
    end
  end

  # def down
  #   remove_column :articles, :status
  #   execute <<-SQL
  #     DROP TYPE status;
  #   SQL
  # end
end
