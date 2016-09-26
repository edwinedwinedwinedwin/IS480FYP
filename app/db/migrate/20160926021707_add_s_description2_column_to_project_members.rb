class AddSDescription2ColumnToProjectMembers < ActiveRecord::Migration
  def change
    add_column :project_members, :sub_description , :text
  end
end
