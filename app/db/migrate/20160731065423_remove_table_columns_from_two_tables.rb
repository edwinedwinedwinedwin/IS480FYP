class RemoveTableColumnsFromTwoTables < ActiveRecord::Migration
  def change
    drop_table :project_likes
    remove_column :users, :address
  end
end
