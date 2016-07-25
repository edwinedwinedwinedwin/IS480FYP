class CreateProjectProposals < ActiveRecord::Migration
  def change
    create_table :project_proposals do |t|
      t.string :title
      t.text :description
      t.references :project_type, foreign_key: true
      t.references :project_category, foreign_key: true
      t.references :project_status, foreign_key: true
      t.string :name
      t.string :email
      t.string :contact_number
      t.timestamps null: false
    end

    create_table :project_proposal_imgs do |t|
      t.references :project_proposal, foreign_key: true
      t.text :img_url
      t.timestamps null: false
    end
  end
end
