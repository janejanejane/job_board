class RenameJobColumns < ActiveRecord::Migration
  def change
    change_table :jobs do |t|
      t.rename :job_title, :jobtitle
      t.rename :job_type, :jobtype
    end
  end
end
