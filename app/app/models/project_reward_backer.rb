class ProjectRewardBacker < ActiveRecord::Base
	include ActiveModel::Validations
	belongs_to :project
end
