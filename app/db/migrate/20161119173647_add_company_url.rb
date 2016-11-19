class AddCompanyUrl < ActiveRecord::Migration
  def change
    change_column :project_reward_backers, :amount_funded, :decimal, precision: 10, scale: 2
    change_column :project_rewards, :min_amount, :decimal, precision: 10, scale: 2

    change_column :project_milestones, :amount_raised, :decimal, precision: 10, scale: 2
    change_column :project_milestones, :target_amount, :decimal, precision: 10, scale: 2

    remove_column :project_proposals, :contact_number
    add_column :project_proposals, :company_url, :string
  end
end
