class AddCountryInformationToProject < ActiveRecord::Migration
  def change
    rename_column :projects, :location, :country
    add_column :projects, :state, :string
    add_column :projects, :city, :string
  end
end
