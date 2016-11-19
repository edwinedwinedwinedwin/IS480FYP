class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :project_reward_name
      t.decimal :amount, precision: 10, scale: 2
      t.string :user_name      
      t.references :user_shipping_address, foreign_key:true
      t.references :user, foreign_key:true
      t.references :project_reward, foreign_key:true
      t.timestamps null: false
    end
  end
end
