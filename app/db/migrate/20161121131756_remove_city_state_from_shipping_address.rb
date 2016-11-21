class RemoveCityStateFromShippingAddress < ActiveRecord::Migration
  def change
 	remove_column :user_shipping_addresses, :city
 	remove_column :user_shipping_addresses, :state
  end
end
