class AddJobPrefPntsAndRemainingPtsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_pref_pnts, :string
    add_column :users, :remaining_pnts, :integer, :default => 10

    add_index :users, :job_pref_pnts
  end
end
