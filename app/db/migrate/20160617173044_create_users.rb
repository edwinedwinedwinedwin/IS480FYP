class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|      
      t.string :email      
      t.string :first_name
      t.string :last_name
      t.string :address
      t.boolean :is_admin
      t.timestamps null: false
    end

  end
end
