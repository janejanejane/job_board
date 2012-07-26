class RenameJobIndex < ActiveRecord::Migration
  def change
    rename_index :jobs, 'index_jobs_on_job_title', 'index_jobs_on_jobtitle'
    rename_index :jobs, 'index_jobs_on_job_type', 'index_jobs_on_jobtype'
  end
end
