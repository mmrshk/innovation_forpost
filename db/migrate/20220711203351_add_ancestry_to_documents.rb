class AddAncestryToDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :ancestry, :string
    add_index :documents, :ancestry
  end
end
