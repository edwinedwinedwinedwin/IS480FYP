class ProjectMember < ActiveRecord::Base

  belongs_to :project
  belongs_to :user
  validates :user, presence: true
  validates :email, :presence=>true
  #validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :role,:presence=>true    
end
