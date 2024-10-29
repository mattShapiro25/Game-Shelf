class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.integer :num_players
      t.integer :num_ratings
      t.float :avg_rating
      t.string :image

      t.timestamps
    end
  end
end
