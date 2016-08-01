class CreateProjectInspirations < ActiveRecord::Migration
  def change
    create_table :project_inspirations do |t|
      t.string :title
      t.text :description
      t.text :img_url, null: false
      t.string :caption
      t.references :project, foreign_key: true
      t.timestamps null: false
    end
  end
end
