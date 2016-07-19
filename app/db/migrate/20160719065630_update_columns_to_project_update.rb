class UpdateColumnstoProjectUpdate < ActiveRecord::Migration
  def change
    change_column_null :project_updates, :img_url, true
    change_column_null :project_updates, :title, false
  end
end
