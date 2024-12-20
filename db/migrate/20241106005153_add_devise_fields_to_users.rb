class AddDeviseFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :email, :string
    add_index :users, :email, unique: true
    add_column :users, :encrypted_password, :string
  end
end
