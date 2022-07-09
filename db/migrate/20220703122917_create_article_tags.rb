class CreateArticleTags < ActiveRecord::Migration[6.0]
  def change
    create_table :article_tags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true, index: false

      t.timestamps
    end
    
    add_index :article_tags, [:article_id, :tag_id], unique: true
  end
end
