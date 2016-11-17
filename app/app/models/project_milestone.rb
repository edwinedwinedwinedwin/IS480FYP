class ProjectMilestone < ActiveRecord::Base

  belongs_to :project
  belongs_to :project_status
end
