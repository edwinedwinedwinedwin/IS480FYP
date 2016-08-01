class CreateProjectRewards < ActiveRecord::Migration
  def change
    create_table :project_rewards do |t|
      t.string :name
      t.decimal :min_amount
      t.text :description
      t.string :estimated_delivery
      t.integer :no_of_rewards
      t.references :project, foreign_key:true

      t.timestamps null: false
    end
  end
end
