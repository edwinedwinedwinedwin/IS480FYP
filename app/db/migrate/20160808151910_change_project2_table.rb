class ChangeProject2Table < ActiveRecord::Migration
  def change

    remove_foreign_key :projects, :project_types
    remove_foreign_key :projects, :project_categories

    remove_reference :projects, :project_category
    remove_reference :projects, :project_type

  end
end
