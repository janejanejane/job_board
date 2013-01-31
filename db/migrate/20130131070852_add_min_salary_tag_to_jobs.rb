class AddMinSalaryTagToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :minimum, :boolean, default: false
  end
end
