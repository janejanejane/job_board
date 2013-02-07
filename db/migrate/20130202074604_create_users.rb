class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
    	t.string :last_name
    	t.string :nickname
    	t.string :personal_statement, :limit => 140
    	t.string :image
    	t.string :location
    	t.string :job_preference
      t.integer :availability
    	t.boolean :new_user, :default => true

      t.timestamps
    end

    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :nickname
    add_index :users, :location
    add_index :users, :job_preference
  end
end
