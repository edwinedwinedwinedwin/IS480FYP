class RemoveCityStateFromProjectProposals < ActiveRecord::Migration
  def change
  	remove_column :project_proposals, :city
  	remove_column :project_proposals, :state
  end
end
