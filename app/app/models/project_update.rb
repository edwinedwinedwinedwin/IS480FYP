class ProjectUpdate < ActiveRecord::Base

  belongs_to :project

  mount_uploader :img_url, ProjectUpdateImgUploader

  validates_presence_of :title, :description
  validates_length_of :description, maximum: 1000
  validates_file_size :img_url, less_than: 5.megabytes
end