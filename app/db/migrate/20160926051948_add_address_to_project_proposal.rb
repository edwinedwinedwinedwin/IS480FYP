class AddAddressToProjectProposal < ActiveRecord::Migration
  def change
    add_column :project_proposals, :country, :text  
    add_column :project_proposals, :state, :text  
    add_column :project_proposals, :city, :text  
  end
end