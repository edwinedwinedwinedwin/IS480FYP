class UpdateColumnsToProjectMembers < ActiveRecord::Migration
  def change
  	rename_column :project_members, :name, :email
  end
end
