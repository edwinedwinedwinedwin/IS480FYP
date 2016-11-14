class ProjectMilestone < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :project
  belongs_to :project_status
end
