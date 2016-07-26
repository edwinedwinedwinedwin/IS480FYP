class ProjectMember < ActiveRecord::Base
  belongs_to :project  
  validates :description,:presence=>true  
  validates_format_of :email, :with => /@/
  validates :email, :presence=>true
  validates :role,:presence=>true    
end
