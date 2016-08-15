class AddEmailToProjectMembers < ActiveRecord::Migration
  def change
  	add_column :project_members, :email, :string  	
  end
end
