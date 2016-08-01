class UpdateColumnsForProjectRewards < ActiveRecord::Migration
  def change
  	add_column :project_rewards, :img_url, :string
  end
end
