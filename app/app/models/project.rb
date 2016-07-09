class Project < ActiveRecord::Base
  belongs_to :project_type
  belongs_to :project_category
  belongs_to :user
  belongs_to :project_status

  has_many :project_updates
  has_many :project_inspirations
  has_many :project_members
  has_many :project_likes
  has_many :project_milestones
  has_many :project_rewards
end
