class ProjectProposal < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :project_proposal_imgs
  belongs_to :project_category
  belongs_to :project_status
  has_one :project

  validates_uniqueness_of :title, client_validations: {class: ProjectProposal}
  validates_presence_of :title, :description
  validates_presence_of :company_url, :estimated_amt_raise, :country,on: :create
  validates_presence_of :name, :email, :creator_title, on: :create
end

