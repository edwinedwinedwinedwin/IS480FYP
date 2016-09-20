class ChangeProjectRewardEstimatedDeliveryDatatype < ActiveRecord::Migration
  def change
    change_column :project_rewards, :estimated_delivery, :date
  end
end
