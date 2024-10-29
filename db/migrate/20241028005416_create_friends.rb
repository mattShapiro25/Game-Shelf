class CreateFriends < ActiveRecord::Migration[7.2]
  def change
    create_table :friends do |t|
      t.integer :user_id1
      t.integer :user_id2

      t.timestamps
    end
  end
end
