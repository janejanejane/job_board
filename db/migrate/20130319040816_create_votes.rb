class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.integer :user_voted
      t.integer :job_preference
      t.string :voters

      t.timestamps
    end
    add_index :votes, :user_voted
    add_index :votes, :voters
  end
end
