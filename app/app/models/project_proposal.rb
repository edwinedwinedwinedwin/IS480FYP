class ProjectProposal < ActiveRecord::Base
  has_many :project_proposal_imgs
  belongs_to :project_category
  belongs_to :project_status
  belongs_to :project_type  
  has_one :project

  validates :title, :description, :first_name, :last_name, :email, :contact_number, :presence => true, :on => :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :contact_number, numericality:{ message: "must be numeric."}    

end
