class ChangeColumnsToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :profile_pic_url
  	add_column :users, :profile_pic, :string
  end
end
