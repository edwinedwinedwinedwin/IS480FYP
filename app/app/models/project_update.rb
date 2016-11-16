class ProjectUpdate < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :project

  mount_uploader :img_url, ProjectUpdateImgUploader

  validates_presence_of :title, :description
  validates_length_of :description, maximum: 1000
  validates_file_size :img_url, less_than: 5.megabytes
end