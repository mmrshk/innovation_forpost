class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :tel
      t.text :password
      t.text :password_confirmation
      t.text :role, default: 'user'

      t.timestamps
    end
  end
end
