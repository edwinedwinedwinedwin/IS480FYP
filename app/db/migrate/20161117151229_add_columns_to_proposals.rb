class AddColumnsToProposals < ActiveRecord::Migration
  def change
    add_column :project_proposals, :creator_title, :string
    add_column :project_proposals, :estimate_amt, :decimal, precision: 10, scale: 2
    add_column :project_proposals, :estimated_start_date, :date
    add_column :project_proposals, :estimated_end_date, :date
    rename_column :project_proposals, :estimate_amt ,:estimated_amt_raise
  end
end
