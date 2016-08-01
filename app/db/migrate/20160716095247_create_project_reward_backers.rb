class CreateProjectRewardBackers < ActiveRecord::Migration
  def change
    create_table :project_reward_backers do |t|

      t.timestamps null: false
      t.decimal :amount_funded
      t.references :user_shipping_address, foreign_key: true
      t.references :user, foreign_key: true
      t.references :project_reward, foreign_key: true
    end
  end
end
