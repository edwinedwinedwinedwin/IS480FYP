# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#List of Project Category
categoryNames = ["Technology", "Education", "Arts", "Entertainment", "Water & Sanitation", "Community", "Health & Fitness", "Finance"]
categoryNames.each do |c|
     ProjectCategory.create!( {:category => c})
end

#List of Project Status
statusList = ["In progress", "Pending", "Approved", "Rejected", "Completed"]
statusList.each do |s|
	ProjectStatus.create!( {:status => s})
end

#List of Project Types
typeList = ["Fundraise for an idea", "Crowdsource my ideas for feedback"]
typeList.each do |t|
  ProjectType.create!( {:types => t})
end