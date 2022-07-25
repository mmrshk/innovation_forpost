class AddIndexOnNameToAttachment < ActiveRecord::Migration[6.0]
  def change
    add_index :attachments, :name
  end
end
