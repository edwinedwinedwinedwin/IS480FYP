class AddStatusToPayments < ActiveRecord::Migration
  def change
  	add_column :payments,:payment_status,:string  	
  	add_reference :payments,:project
    add_foreign_key :payments,:projects
    add_reference :payments,:project_milestone
    add_foreign_key :payments,:project_milestones
  end
end
