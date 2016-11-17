class ProjectProposalImg < ActiveRecord::Base

belongs_to :project_proposal 
  mount_uploader :img_url, ProjectProposalImgUploader
  validates :img_url, file_size: { less_than: 5.megabytes }
end
