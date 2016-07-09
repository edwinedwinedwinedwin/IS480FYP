class CreateProjectUpdates < ActiveRecord::Migration
  def change
    create_table :project_updates do |t|
      t.string :title
      t.text :description
      t.text :img_url, null: false
      t.datetime :created_on
      t.references :project, foreign_key: true
      t.timestamps null: false
    end
  end
end
