class AddColumnsToProposals < ActiveRecord::Migration
  def change
    add_column :project_proposals, :company_url, :string
    add_column :project_proposals, :creator_title, :string
    add_column :project_proposals, :estimate_amt, :decimal, precision: 10, scale: 2
    change_column :project_reward_backers, :amount_funded, :decimal, precision: 10, scale: 2
    change_column :project_rewards, :min_amount, :decimal, precision: 10, scale: 2

    change_column :project_milestones, :amount_raised, :decimal, precision: 10, scale: 2
    change_column :project_milestones, :target_amount, :decimal, precision: 10, scale: 2

    #remove_column :project_proposals, :contact_number
    add_column :project_proposals, :estimated_start_date, :date
    add_column :project_proposals, :estimated_end_date, :date
    rename_column :project_proposals, :estimate_amt ,:estimated_amt_raise
  end
end
