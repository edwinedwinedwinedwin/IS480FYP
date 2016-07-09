class CreateProjectMembers < ActiveRecord::Migration
  def change
    create_table :project_members do |t|
      t.string :name
      t.string :role
      t.text  :img_url, null:false
      t.references :project, foreign_key: true
      t.timestamps null: false
    end
  end
end
