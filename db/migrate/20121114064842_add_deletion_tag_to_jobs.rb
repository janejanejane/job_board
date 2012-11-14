class AddDeletionTagToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :isdeleted, :integer
  end
end
