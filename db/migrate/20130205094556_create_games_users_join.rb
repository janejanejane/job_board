class CreateGamesUsersJoin < ActiveRecord::Migration
  def up
  	create_table :games_users, id: false do |t|
  		t.references :game
  		t.references :user
  	end

  	add_index :games_users, [:game_id, :user_id], :unique => true
  	add_index :games_users, [:user_id, :game_id], :unique => true
  end

  def down
  	drop_table :games_users
  end
end
