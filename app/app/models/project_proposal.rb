class ProjectProposal < ActiveRecord::Base
  has_many :project_proposal_imgs
  belongs_to :project_category
  belongs_to :project_status
  has_one :project


  validates :title, :project_category_id, :presence => true, :on => :step1, :on => :step2
  validates :description, :presence => true, :on => :step2
  validates :first_name, :last_name, :email, :contact_number, :presence => true, :on => :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },:on => :create
  validates :contact_number, numericality:{ message: "must be numeric."},:on => :create

end

