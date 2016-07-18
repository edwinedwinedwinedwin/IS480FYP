class CreateUserExpertises < ActiveRecord::Migration
  def change
    create_table :user_expertises do |t|
      t.timestamps null: false
      t.references :user, foreign_key: true
      t.string :expertise_name
    end
  end
end
