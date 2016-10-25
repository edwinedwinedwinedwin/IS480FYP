class ChangeProjectProposalFirstName < ActiveRecord::Migration
  def change
  	remove_column :project_proposals, :last_name
  	rename_column :project_proposals, :first_name, :name
  end
end
