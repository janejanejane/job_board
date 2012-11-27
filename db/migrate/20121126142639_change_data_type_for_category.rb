class ChangeDataTypeForCategory < ActiveRecord::Migration
  def change
    remove_column :jobs, :category
    add_column :jobs, :category, :integer
  end
end
