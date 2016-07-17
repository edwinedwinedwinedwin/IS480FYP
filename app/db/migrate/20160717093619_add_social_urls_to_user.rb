class AddSocialUrlsToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_pic_url, :string
    add_column :users, :bio_url, :string
    add_column :users, :instagram_url, :string
    add_column :users, :fb_url, :string
    add_column :users, :twitter_url, :string
 end
end
