class AddGameOwnerToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_owner, :integer

    add_index :games, :game_owner
  end
end
