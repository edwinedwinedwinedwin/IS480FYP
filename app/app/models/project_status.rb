class ProjectStatus < ActiveRecord::Base
  has_many :projects
  has_many :project_milestones

end

