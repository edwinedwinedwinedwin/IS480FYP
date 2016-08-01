class RemoveImgUrlFromProjectMembers < ActiveRecord::Migration
  def change
  	remove_column :project_members, :img_url  
  	add_column :project_members, :description, :text
  	add_reference :project_members,:project_status
  	add_foreign_key :project_members,:project_statuses
  end
end
