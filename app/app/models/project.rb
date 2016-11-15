class Project < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :project_category
  belongs_to :user
  belongs_to :project_status
  belongs_to :project_proposal

  has_many :project_updates
  has_many :project_inspirations
  has_many :project_members
  has_many :project_milestones
  has_many :project_rewards


end
