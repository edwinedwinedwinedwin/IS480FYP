class ChangeImgUrlForUploadImages < ActiveRecord::Migration
  def change
  	remove_column :project_rewards, :img_url
  	add_column :project_rewards, :img_url, :string
  	remove_column :project_inspirations, :img_url
  	add_column :project_inspirations, :img_url, :string
  	remove_column :project_updates, :img_url
  	add_column :project_updates, :img_url, :string
  end
end
