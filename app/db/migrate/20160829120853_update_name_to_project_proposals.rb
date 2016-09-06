class UpdateNameToProjectProposals < ActiveRecord::Migration
  def change
  	remove_column :project_proposals, :project_type_id
  	remove_column :project_proposals,:name
  	add_column :project_proposals , :first_name, :string
  	add_column :project_proposals , :last_name, :string
  end
end