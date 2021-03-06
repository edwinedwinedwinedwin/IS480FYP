# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#List of Admin
User.create!(email: 'sean@ybco.com', name: 'Sean Low', is_admin: true, is_banned: false, password: '12345678', password_confirmation: '12345678', fb_url: 'www.facebook.com')
User.create!(email: 'uttam@ybco.com', name: 'Uttam Chopra',is_admin: true, is_banned: false, password: '12345678', password_confirmation: '12345678', fb_url: 'www.facebook.com')
User.create!(email: 'sky@ybco.com', name: 'Sky Chew', is_admin: true, is_banned: false, password: '12345678', password_confirmation: '12345678', fb_url: 'www.facebook.com')
User.create!(email: 'luqman@ybco.com', name: 'Luqman', is_admin: true, is_banned: false, password: '12345678', password_confirmation: '12345678', fb_url: 'www.facebook.com')
User.create!(email: 'edwin@ybco.com', name: 'Edwin Peter', is_admin: true, is_banned: false, password: '12345678', password_confirmation: '12345678', fb_url: 'www.facebook.com')
User.create!(email: 'brendon@ybco.com', name: 'Brendon Koh', is_admin: true, is_banned: false, password: '12345678', password_confirmation: '12345678', fb_url: 'www.facebook.com')
User.create!(email: 'chanel@ybco.com', name: 'Chanel Chiang', is_admin: true, is_banned: false, password: '12345678', password_confirmation: '12345678', fb_url: 'www.facebook.com')

#List of Project Category
categoryNames = ["Technology", "Education", "Arts", "Entertainment", "Water & Sanitation", "Community", "Health & Fitness", "Finance"]
categoryNames.each do |c|
  ProjectCategory.create!( {:category => c})
end


#List of Project Status
  # In progress           (1) - For Project which information not up yet after Project Proposal is Approved
  #                           - For Project MileStone within the period
  # Pending               (2) - For Project Proposal waiting for approval after submitting
  #                           - For Project Member, Creator of the Project send invite to their friend, to be part of their team in.
  # Approved              (3) - For Project Proposal approved
  #                           - For Project Member, Friend accept the request of invitation
  # Rejected              (4) - For Project Proposal rejected
  #                           - For Project Member, Friend reject the request of invitation
  # Completed             (5) - For Project MileStone reach the due date
  # Request For Go Live   (6) - For Project information all fill up and ready to go live
  # Go Live               (7) - For Project is live to display in Projects/index

statusList = ["In progress", "Pending", "Approved", "Rejected", "Completed", "Request For Go Live", "Go Live"]
statusList.each do |s|
  ProjectStatus.create!( {:status => s})
end

