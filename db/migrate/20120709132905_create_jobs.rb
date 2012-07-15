class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :job_title
      t.string :category
      t.string :location
      t.text :description
      t.text :apply_details
      t.string :company_name
      t.string :company_website
      t.string :confirmation_email
      t.decimal :salary, :precision => 10, :scale => 2
      t.string :job_type

      t.timestamps
    end
    
    add_index :jobs, :job_title
    add_index :jobs, :category
    add_index :jobs, :location
    add_index :jobs, :salary
    add_index :jobs, :job_type
  end
end
