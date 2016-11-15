class RemoveCityStateFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :city
    remove_column :projects, :state
  end
end
