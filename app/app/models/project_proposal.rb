class ProjectProposal < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :project_proposal_imgs
  belongs_to :project_category
  belongs_to :project_status
  has_one :project

  #validates :title, :project_category_id, :presence => true, :on => :step1, :on => :step2
  #validates :description, :presence => true, :on => :step2
  #validates :name, :email, :presence => true, :on => :create

  validates_presence_of :name, :email, :description, :title, :project_category_id
  def persisted?

    false
  end
  def underscore
    to_s.underscore
  end

end

