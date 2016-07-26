class ProjectProposal < ActiveRecord::Base
  has_many :project_proposal_imgs
  belongs_to :project_category
  belongs_to :project_status
  belongs_to :project_type

  validates :title, :description, :name, :email, :contact_number, :presence => true, :on => :create
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

end
