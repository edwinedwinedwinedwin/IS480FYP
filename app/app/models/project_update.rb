class ProjectUpdate < ActiveRecord::Base
  belongs_to :project

  mount_uploader :img_url, ProjectUpdateImgUploader
  validates :img_url, file_size: { less_than: 2.megabytes }  
end
