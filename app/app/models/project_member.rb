class ProjectMember < ActiveRecord::Base

  belongs_to :project
  belongs_to :user
  validates :user, presence: true

  validates :email, :presence=>true
  #validates_format_of [:project_member][:email], :with => /@/
  validates :role,:presence=>true    
end
