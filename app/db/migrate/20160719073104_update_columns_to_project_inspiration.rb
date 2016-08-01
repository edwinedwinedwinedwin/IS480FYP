class UpdateColumnsToProjectInspiration < ActiveRecord::Migration
  def change
    change_column_null :project_inspirations, :img_url, true
    change_column_null :project_inspirations, :title, false
  end
end
