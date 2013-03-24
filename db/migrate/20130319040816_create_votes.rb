class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.belongs_to :user
      t.integer :job_preference
      t.integer :user_voted

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :user_voted
  end
end
