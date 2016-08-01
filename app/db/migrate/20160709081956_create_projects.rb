class CreateProjects < ActiveRecord::Migration
  def change

    create_table :project_types do |t|
      t.string :types
      t.timestamps null: false
    end

    create_table :project_categories do |t|
      t.string :category
      t.timestamps null: false
    end

    create_table :project_statuses do |t|
      t.string :status
      t.timestamps null: false
    end

    create_table :projects do |t|

      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.string :location
      t.text :description
      t.datetime :created_on
      t.references :user, foreign_key: true
      t.references :project_type, foreign_key: true
      t.references :project_category, foreign_key: true
      t.references :project_status, foreign_key: true
      t.timestamps null: false
    end

    create_table :project_milestones do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :amount_raised
      t.decimal :target_amount
      t.references :project, foreign_key:true
      t.references :project_status, foreign_key:true
      t.timestamps null: false
    end

  end
end
