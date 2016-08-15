class ProjectInspiration < ActiveRecord::Base
  belongs_to :project

  mount_uploader :img_url, ProjectInspirationImgUploader
  validates :img_url, file_size: { less_than: 2.megabytes }
  validates :title, :description, :presence => true
end

