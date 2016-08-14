class ProjectMember < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  #validates :email, :presence=>true
  #validates_format_of :email, :with => /@/
  validates :role,:presence=>true    
end
