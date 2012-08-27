class AddJobKeyToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :jobkey, :string
    add_column :jobs, :jobkey_confirmation, :string

    add_index :jobs, :jobkey
  end
end
