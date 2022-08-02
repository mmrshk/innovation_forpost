class CreateCkEditorImages < ActiveRecord::Migration[6.0]
  def change
    create_table :ck_editor_images do |t|
      t.string :file
      
      t.references :article, null: true, foreign_key: true, index: true

      t.timestamps
    end
  end
end
