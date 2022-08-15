class AddUrlToCkEditorImage < ActiveRecord::Migration[6.0]
  def change
    add_column :ck_editor_images, :url, :string
  end
end
