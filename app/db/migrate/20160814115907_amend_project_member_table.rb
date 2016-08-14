class AmendProjectMemberTable < ActiveRecord::Migration
  def change
    remove_column :project_members, :email
    add_reference :project_members, :user
    add_foreign_key :project_members, :users
    add_column :project_members, :second_role, :string
  end
end
