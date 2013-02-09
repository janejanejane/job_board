class CreateExtras < ActiveRecord::Migration
  def change
    create_table :extras do |t|
    	t.integer :user_id
      t.string :special_title
      t.integer :experience
      t.string :behance
      t.string :deviantart
      t.string :kongregate
      t.string :gamasutra
      t.string :newgrounds
      t.string :gamejolt

      t.timestamps
    end

    add_index :extras, :user_id
  end
end
