class CreateUserShippingAddresses < ActiveRecord::Migration
  def change
    create_table :user_shipping_addresses do |t|
      	t.timestamps null: false
      	t.string :address_line_1
      	t.string :address_line_2, null: true
      	t.string :country
      	t.string :state, null: true
      	t.string :city, null: true
      	t.string :postal_code
      	t.references :user, foreign_key: true
    end
  end
end
