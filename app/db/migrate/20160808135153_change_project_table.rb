class ChangeProjectTable < ActiveRecord::Migration
  def change
    remove_column :projects, :title
    remove_column :projects, :description
    add_reference :projects, :project_proposal
    add_foreign_key :projects, :project_proposals
  end
end
